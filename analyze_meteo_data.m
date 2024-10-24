%% Setup

clear; clc

time_start = datenum(2023,11,01,06,00,00);
time_end = datenum(2024,07,01,05,00,00);

elev_bands = 0:500:3000;
fields = ["lwr","rhu","swr","tai","wns","snf","rnf"];


%% Load data

load("STAT_LIST.mat")

data_oi_icon = load_oi_data(time_start,time_end,statlist.is_domain,"W:\DATA_OI-snowfall_based\OI_ICON");
data_oi_cosmo = load_oi_data(time_start,time_end,statlist.is_domain,"I:\DATA_OI\OI_INCA");

data_icon = read_icon_data(time_start,time_end,"STAT",statlist.is_domain);
data_cosmo = read_cosmo_data(time_start,time_end,"STAT",statlist.is_domain);

assert(isequal(size(data_oi_icon.snf),size(data_icon.tai)),"Wrong size")
assert(isequal(size(data_oi_cosmo.snf),size(data_cosmo.tai)),"Wrong size")


%% Process data

z = statlist.z(statlist.is_domain);

data_icon.swr = data_icon.sdr + data_icon.sdf;
data_cosmo.swr = data_cosmo.sdr + data_cosmo.sdf;

data_icon.rnf = data_icon.prf;
data_cosmo.rnf = compute_pliquid(data_cosmo.prc,data_cosmo.tai,273.15+1.04,0.15);

data_icon.snf = cumsum(data_oi_icon.snf,1);
data_cosmo.snf = cumsum(data_oi_cosmo.snf,1);

data_icon.rnf = cumsum(data_icon.rnf,1);
data_cosmo.rnf = cumsum(data_cosmo.rnf,1);


%% Compute averages for elevation bands

for field = fields
  for ibin = 1:length(elev_bands)-1
    
    ikeep = z >= elev_bands(ibin) & z < elev_bands(ibin+1);
    
    data_icon.(field + "_mean")(:,ibin) = mean(data_icon.(field)(:,ikeep),2,"omitna");
    data_cosmo.(field + "_mean")(:,ibin) = mean(data_cosmo.(field)(:,ikeep),2,"omitna");
    
  end
end


%% Plot results

close all

for field = fields
  for ibin = 1:length(elev_bands)-1
    
    time = data_icon.time(:,1);
    icon_curr = data_icon.(field + "_mean")(:,ibin);
    cosmo_curr = data_cosmo.(field + "_mean")(:,ibin);
    
    fig = figure("Position",[100 100 1000 800]);
    
    t = tiledlayout(2,1);
    t.TileSpacing = "tight";
    
    title(t,upper(field) + " for elevation band " + elev_bands(ibin) + " - " + elev_bands(ibin+1) + "m")
    
    ax1 = nexttile();
    plot(time,cosmo_curr,"LineWidth",2,"DisplayName","COSMO")
    hold on
    plot(time,icon_curr,"LineWidth",2,"DisplayName","ICON")
    datetick("x")
    legend()
    
    difference = icon_curr - cosmo_curr;
    difference_mean = round(mean(difference),1);
    
    ax2 = nexttile();
    plot(time,difference,"Color","k","LineWidth",2,"DisplayName","COSMO")
    hold on
    plot(time,movmean(difference,30),"Color","r","LineWidth",2,"DisplayName","COSMO")
    yline(0,"LineWidth",2,"LineStyle","--")
    datetick("x")
    text(0.1,0.9,"Mean difference: " + difference_mean,"Units","normalized")
    ylabel("ICON minus COSMO")
    
    filename = field + "_" + elev_bands(ibin) + "-" + elev_bands(ibin+1) + "m.png";
    
    save_plot(fig,"D:\FSM_DEVELOPMENT_2024\fsm_icon_tests\figures",filename)
    
    close all
    
  end
end


%% Analyze bias in wind speed

field = "wns";

ratios_mean = mean(data_cosmo.(field + "_mean"),1)./mean(data_icon.(field + "_mean"),1);

disp(ratios_mean)

for ibin = 1:length(elev_bands)-1
  
  time = data_icon.time(:,1);
  icon_curr = data_icon.(field + "_mean")(:,ibin);
  cosmo_curr = data_cosmo.(field + "_mean")(:,ibin);
  
  icon_curr = icon_curr * ratios_mean(ibin);
  
  fig = figure("Position",[100 100 1000 800]);
  
  t = tiledlayout(2,1);
  t.TileSpacing = "tight";
  
  title(t,upper(field) + " for elevation band " + elev_bands(ibin) + " - " + elev_bands(ibin+1) + "m")
  
  ax1 = nexttile();
  plot(time,cosmo_curr,"LineWidth",2,"DisplayName","COSMO")
  hold on
  plot(time,icon_curr,"LineWidth",2,"DisplayName","ICON")
  datetick("x")
  legend()
  
  difference = icon_curr - cosmo_curr;
  difference_mean = round(mean(difference),1);
  
  ax2 = nexttile();
  plot(time,difference,"Color","k","LineWidth",2,"DisplayName","COSMO")
  hold on
  plot(time,movmean(difference,30),"Color","r","LineWidth",2,"DisplayName","COSMO")
  yline(0,"LineWidth",2,"LineStyle","--")
  datetick("x")
  text(0.1,0.9,{"Mean difference: " + difference_mean,...
    "Correction factor: " + ratios_mean(ibin)},"Units","normalized")
  ylabel("ICON minus COSMO")
  
  filename = field + "_" + elev_bands(ibin) + "-" + elev_bands(ibin+1) + "m - corrected.png";
  
  save_plot(fig,"D:\FSM_DEVELOPMENT_2024\fsm_icon_tests\figures",filename)
  
  close all
  
end


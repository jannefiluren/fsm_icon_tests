function data_oi = load_oi_data(time_start,time_end,is_domain,path)

path = fullfile(path,"OUTPUT_STAT\INPUT");

times = time_start:1:time_end;

data_oi.time = [];
data_oi.snf = [];

for itime = 1:length(times)
  
  time_str = datestr(times(itime),"yyyymmddHHMM");
  
  file = "MODELDATA_" + time_str + "_OI22.mat";

  data_curr = load(fullfile(path,file),"time","snfx","NODATA_value");
  
  data_oi.time = [data_oi.time data_curr.time];
  data_oi.snf = [data_oi.snf; data_curr.snfx.data(is_domain,:)'];
   
end

data_oi.snf(data_oi.snf==data_curr.NODATA_value) = NaN;


end

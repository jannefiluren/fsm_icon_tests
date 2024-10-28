function data_oi = load_oi_data(time_start,time_end,is_domain,path)

path = fullfile(path,"OUTPUT_OSHD_STAT");

times = time_start:1:time_end;

data_oi.snf = [];

for itime = 1:length(times)
  
  time_str = datestr(times(itime),"yyyymmddHHMM");
  
  file = "OIDATA_" + time_str + ".mat";
  
  if isfile(fullfile(path,file))
    data_curr = load(fullfile(path,file),"time","snfx","NODATA_value");
  else
    disp("No file found for: " + time_str + ". Using data from previous day.")
  end
  
  data_oi.snf = [data_oi.snf; data_curr.snfx.data(is_domain,:)'];
   
end

data_oi.snf(data_oi.snf==data_curr.NODATA_value) = NaN;


end

function data_meteo = read_cosmo_data_local(time_start,time_end,geom,is_domain)

times = time_start:1/24:time_end;

for itime = 1:length(times)
  
  paths_meteo = get_paths_meteo(times(itime),geom);
  
  for path_meteo = paths_meteo
    search_str = fullfile(path_meteo,"COSMODATA_" + datestr(times(itime),"yyyymmddHHMM") + "*");
    file = dir(search_str);
    if ~isempty(file)
      break
    end
  end
  
  if isempty(file)
    % throw an error
    error(' ')
  end
  
  if length(file) > 1
    % warn that many files exist
  end
  
  data_curr = load(fullfile(file(1).folder,file(1).name),"acro","time","lwrc","prcs","rhus","sdri","sdfd","tais","wnsc");
  
  data_meteo.time(itime,:) = data_curr.time;
  data_meteo.lwr(itime,:) = data_curr.lwrc.data(is_domain);
  data_meteo.prc(itime,:) = data_curr.prcs.data(is_domain);
  data_meteo.rhu(itime,:) = data_curr.rhus.data(is_domain);
  data_meteo.sdr(itime,:) = data_curr.sdri.data(is_domain);
  data_meteo.sdf(itime,:) = data_curr.sdfd.data(is_domain);
  data_meteo.tai(itime,:) = data_curr.tais.data(is_domain);
  data_meteo.wns(itime,:) = data_curr.wnsc.data(is_domain);
    
end

end


function paths_meteo = get_paths_meteo(time,geom)

paths_meteo = [
  "K:\DATA_COSMO\OUTPUT_OSHD_" + upper(geom) + "\PROCESSED_ANALYSIS\COSMO_1EFA\" + datestr(time,"yyyy.mm"), ...
  "K:\DATA_COSMO\OUTPUT_OSHD_" + upper(geom) + "\PROCESSED_ANALYSIS\COSMO_1_FA\" + datestr(time,"yyyy.mm"), ...
  ];

end
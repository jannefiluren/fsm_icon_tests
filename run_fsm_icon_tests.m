function run_fsm_icon_tests(year)


%% Setup

time_start = datenum(year,9,1);
time_end = datenum(year+1,7,1);

base_folder = "D:\FSM_DEVELOPMENT_2024\FSM_ICON_TESTS_" + year + "_" + (year+1);


% %% FSM.HS - NWP=COSMO + PREC=OI_INCA
% 
% clearvars -except time_start time_end base_folder
% 
% root_folder = fullfile(base_folder,"FSM_COSMO_OI_INCA");
% prec_input_folder = "I:\DATA_OI\OI_INCA";
% meteo_model = "COSMO";
% 
% ansmsg = start_oshd_fsm(0,-1,time_start,"point","init_type","initialize",...
%   "silent",0,"root_folder",root_folder,"prec_input_folder",prec_input_folder,...
%   "time_end",time_end,"meteo_model",meteo_model);
% 
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_COSMO_OI_INCA (FSM.HS)")


% %% FSM.HS - NWP=ICON + PREC=OI_INCA
% 
% clearvars -except time_start time_end base_folder
% 
% root_folder = fullfile(base_folder,"FSM_ICON_OI_INCA");
% prec_input_folder = "I:\DATA_OI\OI_INCA";
% meteo_model = "ICON";
% 
% ansmsg = start_oshd_fsm(0,-1,time_start,"point","init_type","initialize",...
%   "silent",0,"root_folder",root_folder,"prec_input_folder",prec_input_folder,...
%   "time_end",time_end,"meteo_model",meteo_model);
% 
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_ICON_OI_INCA (FSM.HS)")


% %% FSM.HS - NWP=ICON + PREC=ICON+TAIR
% 
% 
% clearvars -except time_start time_end base_folder
% 
% root_folder = fullfile(base_folder,"FSM_ICON_SPLIT_TAIR");
% prec_input_folder = "";
% split_prec_by_tair = true;
% meteo_model = "ICON";
% 
% ansmsg = start_oshd_fsm(0,-1,time_start,"point","init_type","initialize",...
%   "silent",0,"root_folder",root_folder,"prec_input_folder",prec_input_folder,...
%   "time_end",time_end,"meteo_model",meteo_model,"split_prec_by_tair",split_prec_by_tair);
% 
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_ICON_SPLIT_TAIR")


% %% FSM.HS - NWP=ICON + PREC=ICON+SNOWFALL
% 
% clearvars -except time_start time_end base_folder
% 
% root_folder = fullfile(base_folder,"FSM_ICON_SPLIT_SNOWFALL");
% prec_input_folder = "";
% split_prec_by_tair = false;
% meteo_model = "ICON";
% 
% ansmsg = start_oshd_fsm(0,-1,time_start,"point","init_type","initialize",...
%   "silent",0,"root_folder",root_folder,"prec_input_folder",prec_input_folder,...
%   "time_end",time_end,"meteo_model",meteo_model,"split_prec_by_tair",split_prec_by_tair);
% 
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_ICON_SPLIT_SNOWFALL")


% %% FSM.HS - NWP=ICON + PREC=OI_ICON+TAIR
% 
% clearvars -except time_start time_end base_folder
% 
% root_folder = fullfile(base_folder,"FSM_ICON_OI_SPLIT_TAIR");
% prec_input_folder = "W:\DATA_OI-temperature_based\OI_ICON";
% split_prec_by_tair = true;
% meteo_model = "ICON";
% 
% ansmsg = start_oshd_fsm(0,-1,time_start,"point","init_type","initialize",...
%   "silent",0,"root_folder",root_folder,"prec_input_folder",prec_input_folder,...
%   "time_end",time_end,"meteo_model",meteo_model,"split_prec_by_tair",split_prec_by_tair);
% 
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_ICON_OI_SPLIT_TAIR")


%% FSM.HS - NWP=ICON + PREC=OI_ICON+SNOWFALL

clearvars -except time_start time_end base_folder

root_folder = fullfile(base_folder,"FSM_ICON_OI_SPLIT_SNOWFALL");
prec_input_folder = "W:\DATA_OI-snowfall_based\OI_ICON";
split_prec_by_tair = false;
meteo_model = "ICON";

ansmsg = start_oshd_fsm(0,-1,time_start,"point","init_type","initialize",...
  "silent",0,"root_folder",root_folder,"prec_input_folder",prec_input_folder,...
  "time_end",time_end,"meteo_model",meteo_model,"split_prec_by_tair",split_prec_by_tair);

assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_ICON_OI_SPLIT_SNOWFALL")


%% FSM.HS - NWP=ICON + PREC=OI_ICON+SNOWFALL + BIAS_CORR

clearvars -except time_start time_end base_folder

root_folder = fullfile(base_folder,"FSM_ICON_OI_SPLIT_SNOWFALL_BIAS_CORR");
prec_input_folder = "W:\DATA_OI-snowfall_based\OI_ICON";
split_prec_by_tair = false;
meteo_model = "ICON";

bias_corrections.wnsx = 0.7;
bias_corrections.sdrx = 0.9;
bias_corrections.sdfx = 0.9;

ansmsg = start_oshd_fsm(0,-1,time_start,"point","init_type","initialize",...
  "silent",0,"root_folder",root_folder,"prec_input_folder",prec_input_folder,...
  "time_end",time_end,"meteo_model",meteo_model,"split_prec_by_tair",split_prec_by_tair,...
  "bias_corrections",bias_corrections);

assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_ICON_OI_SPLIT_SNOWFALL_BIAS_CORR")


% %% FSM.PF_cluster - NWP=ICON + PREC=OI_ICON+SNOWFALL
% 
% clearvars -except time_start time_end base_folder
% 
% root_folder = fullfile(base_folder,"FSM_PF_ICON");
% prec_input_folder = "W:\DATA_OI-snowfall_based - backup\OI_ICON";
% split_prec_by_tair = true;
% 
% input_pf_rerun = fullfile(root_folder,"FSM_PF_CLUSTERED\PF_RUN\input_perturbation_highest_weight");
% 
% ansmsg = start_oshd_pf(time_start,time_end,"root_folder",root_folder,...
%   "init_type","initialize","prec_input_folder",prec_input_folder,"silent",0,...
%   "split_prec_by_tair",split_prec_by_tair);
% 
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_PF_ICON (FSM.PF_cluster)")
% 
% ansmsg = start_oshd_fsm(0,-1,time_start,"point","time_end",time_end,...
%   "init_type","initialize","input_pf_rerun",input_pf_rerun,...
%   "prec_input_folder",prec_input_folder,"root_folder",root_folder,"silent",0,...
%   "split_prec_by_tair",split_prec_by_tair);
% 
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_PF_ICON (FSM.HS)")


% Run evaluation

experiments = [
  struct("path", fullfile(base_folder,"FSM_COSMO_OI_INCA\FSM_HS\LATEST_00h_RUN"),...
  "desc", "FSM.HS (COSMO+OI_INCA)",...
  "color", "c"),...
  struct("path", fullfile(base_folder,"FSM_PF_ICON\FSM_PF_CLUSTERED\FSM_HS\LATEST_00h_RUN"),...
  "desc", "FSM.PF (ICON+OI_TAIR)",...
  "color", "r"),...
  struct("path", fullfile(base_folder,"FSM_ICON_OI_SPLIT_SNOWFALL\FSM_HS\LATEST_00h_RUN"),...
  "desc", "FSM.HS (ICON+OI_SNOWFALL)",...
  "color", "b"),...
  struct("path", fullfile(base_folder,"FSM_ICON_OI_SPLIT_SNOWFALL_BIAS_CORR\FSM_HS\LATEST_00h_RUN"),...
  "desc", "FSM.HS (ICON+OI_SNOWFALL+BIAS_CORR)",...
  "color", "m"),...
  %   struct("path", fullfile(base_folder,"FSM_ICON_OI_INCA\FSM_HS\LATEST_00h_RUN"),...
  %   "desc", "FSM.HS (ICON+OI_INCA)",...
  %   "color", "y"),...
  %   struct("path", fullfile(base_folder,"FSM_ICON_SPLIT_TAIR\FSM_HS\LATEST_00h_RUN"),...
  %   "desc", "FSM.HS (ICON+P_TAIR)",...
  %   "color", "b"),...
  %   struct("path", fullfile(base_folder,"FSM_ICON_OI_SPLIT_TAIR\FSM_HS\LATEST_00h_RUN"),...
  %   "desc", "FSM.HS (ICON+OI_TAIR)",...
  %   "color", "g"),...
  ];

variable = "hsnt";

save_path = fullfile(base_folder,"EVALUATION");

if ~isfolder(save_path)
  mkdir(save_path)
end

sims = [];

for i = 1:length(experiments)
  sim = load_point_simulation(experiments(i).path,variable);
  sims = [sims; sim];
end
obs = load_observations(variable);

[sims,obs] = innerjoin_oshd(sims,obs,variable,variable);

plot_ts_elevationbands(sims,obs,experiments,variable,variable,"visible","off","save_path",save_path);
stats_automatic_stations(sims,obs,experiments,variable,variable,"visible","off","save_path",save_path);

end




% %% FSM.PF_cluster using ICON+OI precip
%
% s.root_folder = fullfile(base_folder,"FSM_PF_ICON");
% s.prec_input_folder = "W:\DATA_OI\OI_ICON";
%
% input_pf_rerun = fullfile(base_folder,"FSM_PF_ICON\FSM_PF_CLUSTERED\PF_RUN\input_perturbation_highest_weight");
%
% ansmsg = start_oshd_pf(s.time_start,s.time_end,"root_folder",s.root_folder,...
%   "init_type","initialize","prec_input_folder",s.prec_input_folder,"silent",0);
%
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_PF_ICON (FSM.PF_cluster)")
%
% ansmsg = start_oshd_fsm(0,-1,s.time_start,"point","time_end",s.time_end,...
%   "init_type","initialize","input_pf_rerun",input_pf_rerun,...
%   "prec_input_folder",s.prec_input_folder,"root_folder",s.root_folder,"silent",0);
%
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_PF_ICON (FSM.HS)")
%
%
% %% FSM.HS using COSMO+OI precip
%
% s.root_folder = fullfile(base_folder,"FSM_COSMO_OI");
% s.prec_input_folder = "I:\DATA_OI\OI_INCA";
% s.meteo_model = "COSMO";
%
% ansmsg = start_oshd_fsm(0,-1,s.time_start,"point","init_type","initialize",...
%   "silent",0,"root_folder",s.root_folder,"prec_input_folder",s.prec_input_folder,...
%   "time_end",s.time_end,"meteo_model",s.meteo_model);
%
% assert(startsWith(ansmsg,"MSG*"),"Failed to run FSM_COSMO_OI (FSM.HS)")
%
%
% %% Run evaluation
%
% experiments = [
%   struct("path", "D:\FSM_DEVELOPMENT_2024\FSM_ICON_TESTS\FSM_ICON\FSM_HS\LATEST_00h_RUN",...
%     "desc", "FSM.HS (ICON)",...
%     "color", "b"),...
%   struct("path", "D:\FSM_DEVELOPMENT_2024\FSM_ICON_TESTS\FSM_ICON_OI\FSM_HS\LATEST_00h_RUN",...
%     "desc", "FSM.HS (ICON+OI)",...
%     "color", "g"),...
%   struct("path", "D:\FSM_DEVELOPMENT_2024\FSM_ICON_TESTS\FSM_COSMO_OI\FSM_HS\LATEST_00h_RUN",...
%     "desc", "FSM.HS (COSMO+OI)",...
%     "color", "m"),...
%   struct("path", "D:\FSM_DEVELOPMENT_2024\FSM_ICON_TESTS\FSM_PF_ICON\FSM_PF_CLUSTERED\FSM_HS\LATEST_00h_RUN",...
%     "desc", "FSM.PF (ICON+OI)",...
%     "color", "r"),...
% ];
%
% variable = "hsnt";
%
% save_path = fullfile(base_folder,"EVALUATION");
%
% if ~isfolder(save_path)
%   mkdir(save_path)
% end
%
% sims = [];
%
% for i = 1:length(experiments)
%   sim = load_point_simulation(experiments(i).path,variable);
%   sims = [sims; sim];
% end
% obs = load_observations(variable);
%
% [sims,obs] = innerjoin_oshd(sims,obs,variable,variable);
%
% plot_ts_elevationbands(sims,obs,experiments,variable,variable,"visible","off","save_path",save_path);
% stats_automatic_stations(sims,obs,experiments,variable,variable,"visible","off","save_path",save_path);


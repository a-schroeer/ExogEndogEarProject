function[tmp_eog_p30,...
         tmp_eog_m30,...
         tmp_eog_p120,...
         tmp_eog_m120] = exp3_gen_data_helper_eog(subj,stimulusName,addSamples,buffertemplate,eog_maxAngle,eog_maxVal)
     
     % this script converts the eog signal from microVolts to angle
     % the value of eog_maxVal [microVolts] corresponds to the angle
     % eog_maxAngle [degree]. EOG data are scaled linearly accordingly
     
tmp_eog_p30=buffertemplate;
tmp_eog_m30=buffertemplate;

tmp_eog_p120=buffertemplate;
tmp_eog_m120=buffertemplate;

tmpstr=sprintf('*time_stimulus*%s*.mat',stimulusName);
listing=dir(tmpstr);

if size(listing,1) ~=4
 fprintf('\n - - -\n Error: Number of stimulus files not equal to 4:  exp3_gen_data_helper, subj = %i \n - - - \n',subj)
 rand(2).*rand(4)    
end

for k = 1:size(listing,1)
    loadstr=listing(k).name;
   % fprintf('Loading: %s\n',loadstr)
    
   if     ~isempty(strfind(loadstr,'+30'))
        tmpstim_p30=load(loadstr);
        %% Remove 100 zeros at the end            
        tmpstim_p30.eog_time_during(:,end-100:end)=[];      
   elseif ~isempty(strfind(loadstr,'-30'))
        tmpstim_m30=load(loadstr);
        %% Remove 100 zeros at the end            
        tmpstim_m30.eog_time_during(:,end-100:end)=[];   
   elseif ~isempty(strfind(loadstr,'+120'))
        tmpstim_p120=load(loadstr);
        %% Remove 100 zeros at the end            
        tmpstim_p120.eog_time_during(:,end-100:end)=[];
   elseif ~isempty(strfind(loadstr,'-120'))
        tmpstim_m120=load(loadstr);
        %% Remove 100 zeros at the end            
        tmpstim_m120.eog_time_during(:,end-100:end)=[]; 
   else % Error
    fprintf('\n - - -\n Error: Stimulus direction not found:  exp3_gen_data_helper, subj = %i \n - - - \n',subj)
    rand(2).*rand(4)
   end
    
end


      tmp_l_p30=[tmpstim_p30.eog_time_before(subj,:),tmpstim_p30.eog_time_during(subj,:),tmpstim_p30.eog_time_after(subj,:)];

      tmp_l_m30=[tmpstim_m30.eog_time_before(subj,:),tmpstim_m30.eog_time_during(subj,:),tmpstim_m30.eog_time_after(subj,:)];
      
      tmp_l_p120=[tmpstim_p120.eog_time_before(subj,:),tmpstim_p120.eog_time_during(subj,:),tmpstim_p120.eog_time_after(subj,:)];
      
      tmp_l_m120=[tmpstim_m120.eog_time_before(subj,:),tmpstim_m120.eog_time_during(subj,:),tmpstim_m120.eog_time_after(subj,:)];

    
      tmp_l_p30=(tmp_l_p30./eog_maxVal)*eog_maxAngle;
      tmp_l_m30=(tmp_l_m30./eog_maxVal)*eog_maxAngle;       
      tmp_l_p120=(tmp_l_p120./eog_maxVal)*eog_maxAngle;
      tmp_l_m120=(tmp_l_m120./eog_maxVal)*eog_maxAngle;
      

  tmp_eog_m120(1:length(tmp_l_m120)-addSamples)=tmp_l_m120(1:end-addSamples);
  tmp_eog_m120(end-addSamples+1:end)=tmp_l_m120(end-addSamples+1:end);
  
  tmp_eog_p120(1:length(tmp_l_p120)-addSamples)=tmp_l_p120(1:end-addSamples);
  tmp_eog_p120(end-addSamples+1:end)=tmp_l_p120(end-addSamples+1:end);
  
  tmp_eog_m30(1:length(tmp_l_m30)-addSamples)=tmp_l_m30(1:end-addSamples);
  tmp_eog_m30(end-addSamples+1:end)=tmp_l_m30(end-addSamples+1:end);
  
  tmp_eog_p30(1:length(tmp_l_p30)-addSamples)=tmp_l_p30(1:end-addSamples);
  tmp_eog_p30(end-addSamples+1:end)=tmp_l_p30(end-addSamples+1:end);
  
 
end   

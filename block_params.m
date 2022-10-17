load_system('OSWEC')
BlockPaths = find_system('OSWEC/Global Reference Frame/waveVis/waveVisOn/water elevation/marker1/Visualization Block','Type','Block');
handle = getSimulinkBlockHandle('OSWEC/Global Reference Frame/waveVis/waveVisOn/water elevation/marker1/Visualization Block/WaveElevation');
ObjectParameters = get_param(handle,'ObjectParameters');
DialogParameters = get_param(handle,'DialogParameters');
p = Simulink.Mask.get(handle);
MaskVars = p.getWorkspaceVariables;
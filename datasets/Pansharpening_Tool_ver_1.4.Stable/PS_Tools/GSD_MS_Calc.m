function GSD_MS = GSD_MS_Calc(sensor);


switch sensor
       case 'QB'
        GSD_MS = 2.6;
    case 'IKONOS'
        GSD_MS = 4;
    case 'GeoEye1'
    GSD_MS = 1.65;
    case 'WV2'
    GSD_MS = 2;
    case {'WV3','WV3_4bands'}
    GSD_MS = 1.2;
    case {'HYP','HYP_14_33','HYP_16_31'}
    GSD_MS = 30;
    case 'none'
    GSD_MS = 2; %Pleaides    
end

flow = estimateFlow(opticFlow,frameGrey);
[x_new y_new] =  corner(frameGrey,1, ...
                            'QualityLevel', 0.9,'SensitivityFactor',0.04);
flow.Vx(x_new,y_new) = 1;
flow.Vy(x_new,y_new) = 1;
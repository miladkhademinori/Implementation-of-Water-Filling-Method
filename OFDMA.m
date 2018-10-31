%% 1.1

N = 1e-10;
h = [14 10 18 8 4 20 12 3 16 6] * 1e-10;
Landa = 0;
R_Min = 1.5;
Channel_Num = 10;
P = zeros (1,Channel_Num);
P_Max = 0.01; % for uncons P_Max = 10000000 for cons whatever that said
Iteration = 15;

H = h/N;
H_Sorted = sort( H ,'descend');
K_Star_Negative = Channel_Num + 1;
K_Star_FullPower = 0;
R_Min_Dynamic = R_Min;
Landa_History = zeros(1,Iteration);
P_History = zeros(Iteration,10);
R_Min_History = zeros(1,Iteration);

for i = 1:Iteration
    Landa = landa_Calculator ( R_Min_Dynamic , K_Star_FullPower , K_Star_Negative , H_Sorted );
    P = P_Update_Function ( K_Star_FullPower , K_Star_Negative , H_Sorted , Landa , P_Max , Channel_Num );
    P_History ( i , 1:10 ) = P;
    Landa_History ( 1 , i ) = Landa;
    R_Min_History ( 1 , i ) = R_Min_Dynamic;
    [ continue_Flag , K_Star_FullPower , K_Star_Negative , R_Min_Dynamic ] = Final_Check ( P , R_Min_Dynamic , K_Star_FullPower , K_Star_Negative , P_Max , H_Sorted );
     if continue_Flag == 0
         break;
     end
end
%% 1.2 & 1.3 & 1.4
number_Of_Snapshot = 500;
aggregate_Power_Of_Snapshot = zeros ( 1 , number_Of_Snapshot );
for jj = 1 : number_Of_Snapshot
Channel_Num = 200;
X_User_Range = 500;
Y_User_Range = 500;
X_User = X_User_Range * rand( 1 , 1 );
Y_User = Y_User_Range * rand( 1 , 1 );
XY_User = [ X_User Y_User ];
XY_BS = [ 0 0 ];
d = pdist2(XY_User,XY_BS,'euclidean');
u = rand( 1 , Channel_Num ); % generating uniform variates
sigma = 1; % the parameter
x = sigma * sqrt(-2 * log(u)); % generating Rayleigh-distributed variates
h = (d^(-3))*x;
N = 1e-10;
Landa = 0;
R_Min = 50;
P = zeros (1,Channel_Num);
% for uncons P_Max = 10000000; for cons P_Max = 0.01;
P_Max = 0.01;
Iteration = 50;

H = h/N;
H_Sorted = sort( H ,'descend');
K_Star_Negative = Channel_Num + 1;
K_Star_FullPower = 0;
R_Min_Dynamic = R_Min;
Landa_History = zeros(1,Iteration);
P_History = zeros(Iteration,Channel_Num);
R_Min_History = zeros(1,Iteration);

for i = 1:Iteration
    Landa = landa_Calculator ( R_Min_Dynamic , K_Star_FullPower , K_Star_Negative , H_Sorted );
    P = P_Update_Function ( K_Star_FullPower , K_Star_Negative , H_Sorted , Landa , P_Max , Channel_Num );
    P_History ( i , 1:Channel_Num ) = P;
    Landa_History ( 1 , i ) = Landa;
    R_Min_History ( 1 , i ) = R_Min_Dynamic;
    [ continue_Flag , K_Star_FullPower , K_Star_Negative , R_Min_Dynamic ] = Final_Check ( P , R_Min_Dynamic , K_Star_FullPower , K_Star_Negative , P_Max , H_Sorted );
     if continue_Flag == 0
         aggregate_Power_Of_Snapshot ( 1 , jj ) = sum(P) ;
         break;
     end
end

end
Mean = mean(aggregate_Power_Of_Snapshot');
STD = std(aggregate_Power_Of_Snapshot');
fprintf('Answer: %f +- %f  \n', Mean , STD);
%% 2.1

N = 1e-10;
h = [14 10 18 8 4 20 12 3 16 6] * 1e-10;
Landa = 0;
P_Max_Total = 0.05; % R_Min = 1.5;
Channel_Num = 10;
P = zeros (1,Channel_Num);
% for uncons P_Max = 10000000; for cons P_Max = 0.0075;
P_Max = 0.0075;
Iteration = 15;

H = h/N;
H_Sorted = sort( H ,'descend');
K_Star_Negative = Channel_Num + 1;
K_Star_FullPower = 0;
P_Max_Total_Dynamic = P_Max_Total; % R_Min_Dynamic = R_Min;
Landa_History = zeros(1,Iteration);
P_History = zeros(Iteration,Channel_Num);
P_Max_History = zeros(1,Iteration); % R_Min_History = zeros(1,Iteration);
Total_Rate = zeros(1,Iteration);

for i = 1:Iteration
    Landa = landa_Calculator_Part2 ( P_Max_Total_Dynamic , K_Star_FullPower , K_Star_Negative , H_Sorted );
    P = P_Update_Function_Part2 ( K_Star_FullPower , K_Star_Negative , H_Sorted , Landa , P_Max , Channel_Num );
    [ continue_Flag , K_Star_FullPower , K_Star_Negative , P_Max_Total_Dynamic , P ] = Final_Check_Part2 ( P_Max_Total_Dynamic , K_Star_FullPower , K_Star_Negative , P_Max , P );
    P_History ( i , 1:Channel_Num ) = P;
    Landa_History ( 1 , i ) = Landa;
    for k = 1 : Channel_Num
        Total_Rate (1,i) = Total_Rate (1,i) + log2 ( 1 + H_Sorted( 1 , k ) * P ( 1 , k ));
    end
  
     if continue_Flag == 0
         break;
     end
end 

%% 2.2 & 2.3 & 2.4
number_Of_Snapshot = 50000;
aggregate_Rate_Of_Snapshot = zeros ( 1 , number_Of_Snapshot );
for jj = 1 : number_Of_Snapshot
Channel_Num = 200;
X_User_Range = 500;
Y_User_Range = 500;
X_User = X_User_Range * rand( 1 , 1 );
Y_User = Y_User_Range * rand( 1 , 1 );
XY_User = [ X_User Y_User ];
XY_BS = [ 0 0 ];
d = pdist2(XY_User,XY_BS,'euclidean');
u = rand( 1 , Channel_Num ); % generating uniform variates
sigma = 1; % the parameter
x = sigma * sqrt(-2 * log(u)); % generating Rayleigh-distributed variates
h = (d^(-3))*x;
N = 1e-10;
Landa = 0;
P_Max_Total = 1;
P = zeros (1,Channel_Num);
% for uncons P_Max = 10000000; for cons P_Max = 0.01;
P_Max = 10000000;
Iteration = 50;

H = h/N;
H_Sorted = sort( H ,'descend');
K_Star_Negative = Channel_Num + 1;
K_Star_FullPower = 0;
P_Max_Total_Dynamic = P_Max_Total; % R_Min_Dynamic = R_Min;
Landa_History = zeros(1,Iteration);
P_History = zeros(Iteration,Channel_Num);
P_Max_History = zeros(1,Iteration); % R_Min_History = zeros(1,Iteration);
Total_Rate = zeros(1,Iteration);

for i = 1:Iteration
    Landa = landa_Calculator_Part2 ( P_Max_Total_Dynamic , K_Star_FullPower , K_Star_Negative , H_Sorted );
    P = P_Update_Function_Part2 ( K_Star_FullPower , K_Star_Negative , H_Sorted , Landa , P_Max , Channel_Num );
     [ continue_Flag , K_Star_FullPower , K_Star_Negative , P_Max_Total_Dynamic , P ] = Final_Check_Part2 ( P_Max_Total_Dynamic , K_Star_FullPower , K_Star_Negative , P_Max , P );
    P_History ( i , 1:Channel_Num ) = P;
    Landa_History ( 1 , i ) = Landa;
    for k = 1 : Channel_Num
        Total_Rate (1,i) = Total_Rate (1,i) + log2 ( 1 + H_Sorted( 1 , k ) * P ( 1 , k ));
    end
     if continue_Flag == 0
         aggregate_Rate_Of_Snapshot ( 1 , jj ) = Total_Rate (1,i) ;
         break;
     end
end 
end
Mean = mean(aggregate_Rate_Of_Snapshot');
STD = std(aggregate_Rate_Of_Snapshot');
fprintf('Answer: %f +- %f  \n', Mean , STD);
function    Landa = landa_Calculator_Part2 ( P_Max_Total_Dynamic , K_Star_FullPower , K_Star_Negative , H_Sorted )
    Landa = 0 ;
    for i = (K_Star_FullPower + 1) : (K_Star_Negative - 1)
        Landa = (Landa) + (1/H_Sorted( 1 , i));
    end
    Landa = Landa + P_Max_Total_Dynamic;
    Landa = Landa/(K_Star_Negative - K_Star_FullPower - 1);
end

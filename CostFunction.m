function CostFunction()
    close all
    ITER = 51
    % let goal be lane 2
    GOAL = [300.0 2] % goal distance and lane
    goal_lane = GOAL(2)
    goal_dist = GOAL(1)
    max_vel = 50
    lane_0 = 0
    lane_1 = 1
    lane_2 = 2
    % let each lane be 4m wide
    lane_width = 4
    delta_s = linspace(0.0,300,ITER)
    delta_d_l0 = linspace((goal_lane-lane_0)*lane_width,(goal_lane-lane_0)*lane_width,ITER)
    delta_d_l1 = linspace((goal_lane-lane_1)*lane_width,(goal_lane-lane_1)*lane_width,ITER)
    delta_d_l2 = linspace((goal_lane-lane_2)*lane_width,(goal_lane-lane_2)*lane_width,ITER)
    
    % cost function depends on speed, distance to goal, distance to target
    % cost = 1 - exp(-delta_d/delta_s)
    
    current_vel = max_vel;
    
    % function that penalises wrong lanes
    Klane = 0.5
    cost_lane_0 = 1 - 1./(1+Klane*(delta_d_l0./(goal_dist-delta_s+0.0001)))
    cost_lane_1 = 1 - 1./(1+Klane*(delta_d_l1./(goal_dist-delta_s+0.0001)))
    cost_lane_2 = 1 - 1./(1+Klane*(delta_d_l2./(goal_dist-delta_s+0.0001)))
    
    current_vel = max_vel;
    
    % function that penalises low speeds
    Kvel = 1
    cost_lane_0_vmax = cost_lane_0 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    cost_lane_1_vmax = cost_lane_1 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    cost_lane_2_vmax = cost_lane_2 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    
    current_vel = max_vel/2
    cost_lane_0_vmed = cost_lane_0 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    cost_lane_1_vmed = cost_lane_1 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    cost_lane_2_vmed = cost_lane_2 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    
    current_vel = 0.001
    cost_lane_0_vmin = cost_lane_0 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    cost_lane_1_vmin = cost_lane_1 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    cost_lane_2_vmin = cost_lane_2 + 1-1./(1+Kvel*(goal_dist-delta_s)/goal_dist.*((max_vel-current_vel)/max_vel))
    
    %normalise costs
    cost_lane_0_vmax = cost_lane_0_vmax/2
    cost_lane_1_vmax = cost_lane_1_vmax/2
    cost_lane_2_vmax = cost_lane_2_vmax/2

    cost_lane_0_vmed = cost_lane_0_vmed/2
    cost_lane_1_vmed = cost_lane_1_vmed/2
    cost_lane_2_vmed = cost_lane_2_vmed/2
 
    cost_lane_0_vmin = cost_lane_0_vmin/2
    cost_lane_1_vmin = cost_lane_1_vmin/2
    cost_lane_2_vmin = cost_lane_2_vmin/2
    
    figure(1)
    hold on;
    plot (delta_s,cost_lane_0_vmax,'+-r')
    plot (delta_s,cost_lane_1_vmax,'+-b')
    plot (delta_s,cost_lane_2_vmax,'+-g')
    plot (delta_s,cost_lane_0_vmed,'o-r')
    plot (delta_s,cost_lane_1_vmed,'o-b')
    plot (delta_s,cost_lane_2_vmed,'o-g')
    plot (delta_s,cost_lane_0_vmin,'x-r')
    plot (delta_s,cost_lane_1_vmin,'x-b')
    plot (delta_s,cost_lane_2_vmin,'x-g')
    legend('lane 0, v=max','lane 1, v=max','lane 2, v=max', ...
           'lane 0, v=med','lane 1, v=med','lane 2, v=med', ...
           'lane 0, v=min','lane 1, v=min','lane 2, v=min')
    xlabel('distance')
    ylabel('cost')
end
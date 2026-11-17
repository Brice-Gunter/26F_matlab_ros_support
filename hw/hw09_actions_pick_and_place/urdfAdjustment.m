function robot = urdfAdjustment(robot,name,toolFlag)
% Adjusts Forward Kins according to URDF

    % Set specific adjustments depending on the robot
    if  strcmpi(name,'UR5e')

        % shoulder_link needs to be rotated by 90 degrees around Z wrt parent
        tform=robot.getBody('base_link_inertia').Joint.JointToParentTransform;    
        robot.getBody('base_link_inertia').Joint.setFixedTransform(tform*eul2tform([pi/2,0,0]));
        
        % upper_arm_link needs to be rotated by -90 degrees around Z wrt parent
        tform=robot.getBody('upper_arm_link').Joint.JointToParentTransform;
        robot.getBody('upper_arm_link').Joint.setFixedTransform(tform*eul2tform([-pi/2,0,0]));
        
        % Wrist_2_link needs to be rotated by -90 degrees around Z wrt parent
        tform=robot.getBody('wrist_2_link').Joint.JointToParentTransform;
        robot.getBody('wrist_2_link').Joint.setFixedTransform(tform*eul2tform([-pi/2,0,0]));

        % Add rigidTool as indicated at https://github.com/mathworks-robotics/Intelligent-Bin-Picking-with-Universal-Robot/blob/main/Motion%20Planning/exampleHelperAddGripper.m
        if toolFlag
            robot = exampleHelperAddGripper(robot);
        end
    end
end
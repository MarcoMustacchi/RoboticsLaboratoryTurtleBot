%% 
rostopic info /turtlebot_03/cmd_camera_pantilt                                                 
Type: std_msgs/Int8MultiArray                                                                                                                                                                                                                   
Publishers: None                                                                                                                                                                                                                                
Subscribers:                                                                                                             
* /turtlebot_03/rosserial (http://147.162.118.156:44441/) 
% romsg show
rosmsg show std_msgs/Int8MultiArray                                                            
std_msgs/MultiArrayLayout layout                                                                                          
    std_msgs/MultiArrayDimension[] dim                                                                                        
        string label                                                                                                            
        uint32 size                                                                                                             
        uint32 stride                                                                                                         
    uint32 data_offset                                                                                                    
int8[] data 

%%
% info
rostopic info /turtlebot_03/ultrasonicDistance                                                 
Type: std_msgs/Float32                                                                                                                                                                                                                          
Publishers:                                                                                                              
* /turtlebot_03/rosserial (http://147.162.118.156:44441/)                                                                                                                                                                                      
Subscribers: None 
% rosmsh show
rosmsg show std_msgs/Float32                                                                   
float32 data 
% hz
rostopic hz /turtlebot_03/ultrasonicDistance                                                   
subscribed to [/turtlebot_03/ultrasonicDistance]                                                                        
average rate: 8.813                                                                                                             
min: 0.055s max: 0.175s std dev: 0.04447s window: 8 
% bw
rostopic bw /turtlebot_03/ultrasonicDistance                                                   
subscribed to [/turtlebot_03/ultrasonicDistance]
average: 32.21B/s                                                                                                               
mean: 4.00B min: 4.00B max: 4.00B window: 100

 %% 
 % info
 rostopic info /turtlebot_03/wheelSpeeds                                                        
 Type: geometry_msgs/Vector3                                                                                                                                                                                                                     
 Publishers:                                                                                                              
 * /turtlebot_03/rosserial (http://147.162.118.156:44441/)                                                                                                                                                                                      
 Subscribers: None 
 % msg show
 rosmsg show geometry_msgs/Vector3                                                              
 float64 x                                                                                                               
 float64 y                                                                                                               
 float64 z 
 % hz
rostopic hz /turtlebot_03/wheelSpeeds                                                          
subscribed to [/turtlebot_03/wheelSpeeds]                                                                               
 average rate: 38.694                                                                                                            
 min: 0.022s max: 0.033s std dev: 0.00278s window: 38
 % bandwidth
rostopic bw /turtlebot_03/wheelSpeeds                                                          
subscribed to [/turtlebot_03/wheelSpeeds] 
 average: 946.43B/s                                                                                                              
 mean: 24.00B min: 24.00B max: 24.00B window: 100 


 %%
 rostopic info /turtlebot_03/cmd_wheels                                                         
 Type: geometry_msgs/Vector3                                                                                                                                                                                                                     
 Publishers: None                                                                                                                                                                                                                                
 Subscribers:                                                                                                             
 * /turtlebot_03/rosserial (http://147.162.118.156:44441/)  
 % rosmsg show
 rosmsg show geometry_msgs/Vector3                                                              
 float64 x                                                                                                               
 float64 y                                                                                                               
 float64 z

 %%
 rostopic info /turtlebot_03/gyro                                                               
 Type: geometry_msgs/Vector3                                                                                                                                                                                                                     
 Publishers:                                                                                                              
 * /turtlebot_03/rosserial (http://147.162.118.156:44441/)                                                                                                                                                                                      
 Subscribers: None 
 % rosmsg show
 rosmsg show geometry_msgs/Vector3                                                              
 float64 x                                                                                                               
 float64 y                                                                                                               
 float64 z
 % pub rate hz
 rostopic hz /turtlebot_03/gyro                                                                 
 subscribed to [/turtlebot_03/gyro]                                                                                      
 average rate: 84.935                                                                                                            
 min: 0.009s max: 0.017s std dev: 0.00197s window: 83 
 % bandwidth
 rostopic bw /turtlebot_03/gyro                                                                 
 subscribed to [/turtlebot_03/gyro]                                                                                      
average: 2.06KB/s                                                                                                               
mean: 0.02KB min: 0.02KB max: 0.02KB window: 100   

%% 
rostopic info /turtlebot_03/raspicam_node/camera_info                                         
Type: sensor_msgs/CameraInfo                                                                                                                                                                                                                    
Publishers:                                                                                                              
* /turtlebot_03/raspicam_node (http://147.162.118.156:37713/)                                                                                                                                                                                  
Subscribers: None 

rostopic info /turtlebot_03/raspicam_node/image/compressed                                     
Type: sensor_msgs/CompressedImage                                                                                                                                                                                                               
Publishers:                                                                                                              
* /turtlebot_03/raspicam_node (http://147.162.118.156:37713/)                                                                                                                                                                                  
Subscribers: None 

rostopic hz /turtlebot_03/raspicam_node/image/compressed                                       
subscribed to [/turtlebot_03/raspicam_node/image/compressed]                                                            
average rate: 30.024                                                                                                            
min: 0.027s max: 0.039s std dev: 0.00248s window: 30 

rosmsg show sensor_msgs/CompressedImage                                                        
std_msgs/Header header                                                                                                    
    uint32 seq                                                                                                              
    time stamp                                                                                                              
    string frame_id                                                                                                       
string format                                                                                                           
uint8[] data 

rostopic type /turtlebot_03/raspicam_node/image/compressed                                     
sensor_msgs/CompressedImage

%% lidar node
% to start the lidar, plug in the usb and then start the node from cmd
% laser scan -> we read 360 degree using ros topic echo
header:                                                                                                                 
Sequence: 1309                                                                                                               
stamp:                                                                                                                    
secs: 1679408105                                                                                                        
nsecs: 740080641                                                                                                      
frame_id: "laser"                                                                                                     
angle_min: -3.1241390705108643                                                                                          
angle_max: 3.1415927410125732                                                                                           
angle_increment: 0.01745329238474369                                                                                    
time_increment: 0.0004118878860026598                                                                                   
scan_time: 0.14786775410175323                                                                                          
range_min: 0.15000000596046448                                                                                          
range_max: 12.0                                                                                                         
ranges: "<array type: float32, length: 360>"                                                                            
intensities: "<array type: float32, length: 360>" 

rostopic hz /turtlebot_03/scan                                                                 
subscribed to [/turtlebot_03/scan]                                                                                      
average rate: 6.259                                                                                                             
min: 0.156s max: 0.162s std dev: 0.00187s window: 6 

%% Line error
rostopic hz /turtlebot_03/lineError                                                            
subscribed to [/turtlebot_03/lineError]                                                                                 
average rate: 10.016                                                                                                            
min: 0.097s max: 0.103s std dev: 0.00143s window: 10 

%% to shutdown Turtlebot
% sudo shutdown now
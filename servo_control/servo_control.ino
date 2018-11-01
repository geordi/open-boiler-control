// https://electronics.stackexchange.com/questions/77502/is-there-a-way-to-stop-servos-from-shaking

#include <Servo.h>

#define NO_SERVOS          4

#define SERVO_BACK         0
#define SERVO_UP           1
#define SERVO_DOWN         2
#define SERVO_ENTER        3

#define SERVO_PIN_BACK     9
#define SERVO_PIN_UP      10
#define SERVO_PIN_DOWN    11
#define SERVO_PIN_ENTER    6

#define ANGLE_PUSH        20
#define ANGLE_RETRACT     10

#define INIT_SERVO_ANGLE   ANGLE_RETRACT // init servo position in degrees

#define SERVO_COMMAND_DELAY 350

int servo_pins[ NO_SERVOS ] = { SERVO_PIN_BACK, SERVO_PIN_UP, SERVO_PIN_DOWN, SERVO_PIN_ENTER };
int servo_init_angles[ NO_SERVOS ] = { 77, 30, 95, 95 };

Servo servos[ NO_SERVOS ];  

int servo_back_angle_push = 97;
int servo_back_angle_retract = 77;

int servo_up_angle_push = 10;
int servo_up_angle_retract = 30;

int servo_down_angle_push = 115;
int servo_down_angle_retract = 95;

int servo_enter_angle_push = 115;
int servo_enter_angle_retract = 95;


void setup()
{
    for ( int i = 0; i < NO_SERVOS; i++ ) {
        pinMode( servo_pins[ i ], INPUT );
    }

    Serial.begin(115200);

    for ( int i = 0; i < NO_SERVOS; i++ ) {
        servos[ i ].attach( servo_pins[ i ] );
        delay( SERVO_COMMAND_DELAY );
        pinMode( servo_pins[ i ], OUTPUT );
        servos[ i ].write( servo_init_angles[ i ] );
        delay( SERVO_COMMAND_DELAY );
        pinMode( servo_pins[ i ], INPUT );
    }
}
 

void push_and_release_button( int servo_id ) {
    // BACK - positive angle to push
    // UP - negative
    // DOWN - positive angle to push
    // ENTER - positive angle to push

    int angle_push = ANGLE_PUSH;
    int angle_retract = ANGLE_RETRACT;

    if ( servo_id == SERVO_BACK ) {
        angle_push = servo_back_angle_push;
        angle_retract = servo_back_angle_retract;
    }
    else if ( servo_id == SERVO_UP ) {
        angle_push = servo_up_angle_push;
        angle_retract = servo_up_angle_retract;
    }
    else if ( servo_id == SERVO_DOWN ) {
        angle_push = servo_down_angle_push;
        angle_retract = servo_down_angle_retract;
    }
    else if ( servo_id == SERVO_ENTER ) {
        angle_push = servo_enter_angle_push;
        angle_retract = servo_enter_angle_retract;
    }

    Servo * servo = &servos[ servo_id ];
    //delay( SERVO_COMMAND_DELAY );
    pinMode( servo_pins[ servo_id ], OUTPUT );
    delay( 10 );
    
    servo->write( angle_push );
    
    delay( SERVO_COMMAND_DELAY );
    
    servo->write( angle_retract );
    
    delay( SERVO_COMMAND_DELAY );
    pinMode( servo_pins[ servo_id ], INPUT );
    delay( 10 );
}


void loop()
{
    // Searial.setTimeout( 2000 )
  
    if ( Serial.available() > 0 ) {
        byte b[80];
        Serial.readBytes( b, 1 );
        //int incomming_command = Serial.read();
        byte incomming_command = b[ 0 ];

        //Serial.print( "Received:" );
        //Serial.println( i, DEC );

        if ( incomming_command == 'U' ) {
            push_and_release_button( SERVO_UP );
        }
        else if ( incomming_command == 'B' ) {
            push_and_release_button( SERVO_BACK );
        }
        else if ( incomming_command == 'D' ) {
            push_and_release_button( SERVO_DOWN );
        }
        else if ( incomming_command == 'E' ) {
            push_and_release_button( SERVO_ENTER );
        }
        else if ( incomming_command == 'L' ) {
            //Serial.println( "Load OP" );
            //Serial.readBytes( b, 1);
            //Serial.print( "Will update servo:" );
            //Serial.println( b[0] );
        }
    }
    /*
    push_and_release_button( SERVO_BACK );
    push_and_release_button( SERVO_UP );

    push_and_release_button( SERVO_DOWN );
    push_and_release_button( SERVO_ENTER );

    //test_up_button();
    
    delay( 2000 );
    */
    
   /*
   servos[ SERVO_BACK ].write(5);      // Turn SG90 servo Left to 45 degrees
   delay(1000);          // Wait 1 second
   servos[ SERVO_BACK ].write(10);      // Turn SG90 servo back to 90 degrees (center position)
   delay(1000);          // Wait 1 second
   servos[ SERVO_UP ].write(15);     // Turn SG90 servo Right to 135 degrees
   delay(1000);          // Wait 1 second
   servos[ SERVO_UP ].write(20);      // Turn SG90 servo back to 90 degrees (center position)
   delay(1000);
   */

//if you change the delay value (from example change 50 to 10), the speed of the servo changes
  /*
  for(servoAngle = 0; servoAngle < 180; servoAngle++)  //move the micro servo from 0 degrees to 180 degrees
  {                                  
    servo.write(servoAngle);              
    delay(50);                  
  }

  for(servoAngle = 180; servoAngle > 0; servoAngle--)  //now move back the micro servo from 0 degrees to 180 degrees
  {                                
    servo.write(servoAngle);          
    delay(10);      
  }
  */
  //end control the servo's speed  
}

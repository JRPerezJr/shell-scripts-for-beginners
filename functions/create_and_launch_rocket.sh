function launch_rocket(){
    rocket-start-power $1
    rocket-internal-power $1
    rocket-start-sequence $1
    rocket-start-engine $1
    rocket-lift-off $1
}

mission_name=$1

mkdir $mission_name

rocket-add $mission_name

launch_rocket $mission_name

rocket_status=$(rocket-status $mission_name)

echo "The status of launch is $rocket_status"

if [ $rocket_status = "launching" ]
then
  sleep 2
  rocket_status=$(rocket-status $mission_name)
fi

if [ $rocket_status = "failed" ]
then
  rocket-debug
fi
# Go to the user folder for the user "pi"
cd /home/pi
# Create a new folder for our git repositories
mkdir git
# Go to the repos
cd git
# Clone the "raspberry-pi" repository
yes "yes" | git clone git+ssh://git@github.com/Neylion/raspberry-pi.git

<img src="./readme/title1.svg"/>

<br><br>

<!-- project philosophy -->
<img src="./readme/title2.svg"/>

> Recyclify is a mobile application designed to streamline the efforts of environmentalists. Our cutting-edge solution integrates advanced recycling technology, providing users with smart recycling containers equipped with advanced sensors. Our drivers will come to you when your container is full, empowering users by eliminating the need to personally locate recycling centers or manage disposal logistics.

> We believe in creating a greener future by empowering individuals to take simple yet impactful actions through our platform.

### User Stories

#### User

- As a user, I want to have a smart container that measures its fullness.
- As a user, I want to receive notifications about the status of the containers.
- As a user, I want to request a driver when one of the containers is full.

#### Driver

- As a driver, I want to have a chat with the user to confirm the pickup time.
- As a driver, I want to receive notifications when users request a driver.
- As a driver, I want to see the user's location to plan my route efficiently.

#### Admin

- As an admin, I want to view the statistics of users and drivers.
- As an admin, I want to manage users and drivers.
- As an admin, I want to create new drivers.

<br><br>
<!-- Tech stack -->
<img src="./readme/title3.svg"/>

###  Recyclify is built using the following technologies:

- This project uses the [Flutter app development framework](https://flutter.dev/). Flutter is a cross-platform hybrid app development platform which allows us to use a single codebase for apps on mobile, desktop, and the web.
- For persistent storage (database), the app uses the [Laravel](https://https://laravel.com/) facilitating custom storage schema creation, efficient data management, and seamless integration with local databases.
- To send local push notifications, the app uses the [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications) package which supports Android, iOS, and macOS.
- The app uses the font ["Roboto"](https://fonts.google.com/specimen/Roboto) as its main font, and the design of the app adheres to the material design guidelines.

<br><br>
<!-- UI UX -->
<img src="./readme/title4.svg"/>


> We designed Recyclify using wireframes and mockups, iterating on the design until we reached the ideal layout for easy navigation and a seamless user experience.

- Project Figma design [figma](https://www.figma.com/design/tiAnUrwo2JuwhigydQYuu3/Recyclify?node-id=0-1&t=HpSa3lU5BdZMIfPe-0)


### Mockups
| Home screen  | Home Screen | Messages |
| ---| ---| ---|
| ![Landing](./readme/HomePage.png) | ![fsdaf](./readme/HomePage1.png) | ![fsdaf](./readme/ChatRoom.png) |

<br><br>

<!-- Database Design -->
<img src="./readme/title5.svg"/>

###  Architecting Data Excellence: Innovative Database Design Strategies:

<img src="./readme/ERD.png" height="500" />


<br><br>


<!-- Implementation -->
<img src="./readme/title6.svg"/>


### User Screens (Mobile)
| Splash screen | Login screen  | Register screen | Loading screen |
| ---| ---| ---| ---|
| ![Landing](./readme/SplashScreen.gif) | ![fsdaf](./readme/Login.gif) | ![fsdaf](./readme/SignUp.gif) | ![fsdaf](./readme/Loading.gif) |
| Home screen  | Messages screen | Notification screen | Profile screen |
| ![Landing](./readme/UserHome.gif) | ![fsdaf](./readme/UserMessage.gif) | ![fsdaf](./readme/UserNotification.jpg) | ![fsdaf](./readme/UserProfile.jpg) |

### Driver Screens (Mobile)
| Home screen  | Messages screen | Notification screen | Profile screen |
| ---| ---| ---| ---|
| ![Landing](./readme/DriverHome.gif) | ![fsdaf](./readme/DriverMessage.gif) | ![fsdaf](./readme/DriverNotification.jpg) | ![fsdaf](./readme/DriverProfile.jpg) |

### Admin Screens (Web)
| Login Screen  | Dashboard |
| ---| ---|
| ![Landing](./readme/AdminLogin.png) | ![fsdaf](./readme/Dashboard.png) |
| Users Table  | Create driver |
| ![Landing](./readme/UsersTable.png) | ![fsdaf](./readme/CreateDriver.png) |

<br><br>


<!-- Prompt Engineering -->
<!-- <img src="./readme/title7.svg"/>

###  Mastering AI Interaction: Unveiling the Power of Prompt Engineering:

- This project uses advanced prompt engineering techniques to optimize the interaction with natural language processing models. By skillfully crafting input instructions, we tailor the behavior of the models to achieve precise and efficient language understanding and generation for various tasks and preferences.

<br><br> -->

<!-- AWS Deployment -->
<img src="./readme/title8.svg"/>

###  Streamlined Deployment with AWS: Making it Simple and Efficient:

- This project uses AWS deployment methods to simplify how software is integrated and launched. Focusing on scalability, reliability, and speed, we ensure that applications deployed this way are strong and work well for different needs.

Below were the steps taken to deploy recyclify's Laravel backend to AWS, after [connecting to the AWS EC2 instance through PuTTY](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/putty.html). Special thanks to [the Step-by-Step Guide: Hosting a Laravel Application on AWS EC2 with RDS on Medium.com](https://medium.com/@shairaliyamin/step-by-step-guide-hosting-a-laravel-application-on-aws-ec2-with-rds-b1c3f16db315).

- **Step 1**: Update Packages
  ```sh
  sudo apt update
  sudo apt upgrade -y
  ```
- **Step 2**: Install Composer, Apache and PHP
  ```sh
  sudo apt install composer -y
  sudo apt-get install apache2
  sudo apt-get install php-mysql
  ```
- **Step 3**: Create Virtual Hosts File
  ```sh
  sudo nano /etc/apache2/sites-available/laravel.conf
  ```
- **Step 4**: Copy and paste the following snippet into `laravel.conf`:

  ```
  <VirtualHost *:80>
      ServerName <YOUR_IPv4_ADDRESS_HERE>
      DocumentRoot /var/www/html/recyclify/backend/public

      <Directory /var/www/html/recyclify/backend/public>
         AllowOverride All
         Require all granted
     </Directory>
     ProxyRequests Off
     ProxyPass / http://127.0.0.1:8000/
     ProxyPassReverse / http://127.0.0.1:8000/

     <Proxy *>
         Order allow,deny
         Allow from all
     </Proxy>

     ErrorLog ${APACHE_LOG_DIR}/error.log
     CustomLog ${APACHE_LOG_DIR}/access.log combined
  </VirtualHost>
  ```

  Replace `YOUR_IPv4_ADDRESS_HERE` with your AWS EC2 instance's IPv4 Public Address.

- **Step 5**: Activate your virtual host setup, then reload Apache:
  ```sh
  sudo a2ensite laravel
  sudo systemctl reload apache2
  ```
- **Step 6**: Clone this repository, then set permissions
  ```sh
  cd /var/www/html
  sudo git clone https://github.com/Huseinaz/Recyclify.git /var/www/html/recyclify
  sudo chown -R ubuntu:ubuntu /var/www/html/recyclify
  ```
  Replace `ubuntu:ubuntu` with your instance username.
- **Step 7**: Install MySQL on your instance. A good guide can be found here: [How To Install MySQL on Ubuntu 20.04 (DigitalOcean)](https://www.digitalocean.com/community/tutorials/how-to-install-mysql-on-ubuntu-20-04)

- **Step 8**: Once MySQL is installed, follow the steps in the "How To Run?" section below (Backend Setup).

<img src="./readme/AWSTest.png" height="500" />

<br><br>

<!-- Unit Testing -->
<img src="./readme/title9.svg"/>

###  Precision in Development: Harnessing the Power of Unit Testing:

- This project focuses on testing every part of the code carefully to make sure it works well. By checking each piece of the software closely, we build a strong base, catching and fixing any problems early in development.

<img src="./readme/UnitTesting.png" height="450" />

<br><br>


<!-- How to run -->
<img src="./readme/title10.svg"/>

> To set up Recyclify locally, follow these steps:

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Clone the repo

    ```sh
    git clone https://github.com/Huseinaz/Recyclify.git
    ```

2. Install Laravel dependencies by navigating to the Laravel project directory:

   ```sh
   cd backend
   composer install
   ```

3. Set up your Laravel environment and configure the .env file with your database settings.

   Run Laravel migrations to set up the database:

   ```sh
   php artisan migrate --seed
   ```

4. Navigate to the Flutter app directory:

   ```sh
   cd mobile
   ```

5. Install Flutter dependencies and run the Flutter app on your emulator or connected device:

   ```sh
   flutter pub get
   flutter run
   ```

6. Navigate to the ReactJS project directory:

   ```sh
   cd frontend
   ```

7. Install ReactJS dependencies and run the ReactJS app:

   ```sh
   npm start
   ```

Now, you should be able to run Recyclify locally and explore its features.

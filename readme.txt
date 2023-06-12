(TO RUN FLASK API)
1) Open an IDE
2) Change current directory in terminal to Project/Flask
3) Create a target directory for virtual environment using: python -m venv env
4) Enter the virtual environment using env/Scripts/activate
5) Then install following libraries using following commands:
	pip install flask
	pip install pandas
	pip install scikit-learn==1.0.1
6) Run app.py file on terminal using : python app.py
7) It will then start to run on an 2 IP addresses, copy the second IP address, copy the second IP address

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

(TO BUILD .APK FILE)
NOTE:
->First Download flutter sdk using this link: https://docs.flutter.dev/get-started/install
->Update your path(steps is given in the website)
->Run the command : flutter doctor
->It will show you whether there is any issue in any category.If there is, resolve it before moving on
	
1)Go inside flutter_application_1 folder, then go inside lib folder. Open home.dart file
2)Paste the IP address on line 89 (currently it will be : String i = "http://192.168.1.70:5001";)
3)Do the same on line 100 (currently it will be : String j = "http://192.168.1.70:5001/result"; ) but don't remove '/result' from the end
4)Open an IDE
5)Make sure current directory is Flask/flutter_application_1
4)Now run this command to build the app (in terminal) : flutter build apk --release --no-sound-null-safety
5)The app will be build in :Project\flutter_application_1\build\app\outputs\flutter-apk\app-release.apk
6)Transfer the .apk onto mobile and install it
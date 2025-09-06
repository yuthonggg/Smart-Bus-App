🚍 RideWise – Smart Campus Mobility Assistant
-----------------------------------------------------------------------------------------------------------------------------------------
RideWise is a smart real-time bus occupancy and prediction platform designed to improve campus mobility. It combines IoT hardware, cloud infrastructure, and machine learning to help students make smarter commuting decisions and reduce wasted time waiting for overcrowded buses.
-----------------------------------------------------------------------------------------------------------------------------------------
✨ Key Features

1. Seat Occupancy Detection – IR sensors mounted behind bus seats track real-time availability.
2. Bus Location Tracking – GPS modules report live bus positions to the cloud.
3. Station Crowd Monitoring – Optional cameras at bus stops provide live snapshots of waiting crowds.
4. Cloud Integration – Data streamed to Firebase for real-time storage, processed via Apache Kafka for scalability.
5. Predictive Analytics – Machine learning models on AWS forecast peak congestion and future bus occupancy levels.
6. Mobile App (Flutter/React Native) – Students can:
7. View bus ETA + real-time seat availability
8. Compare “🚶 Walk vs 🚌 Bus” times
9. Check live station conditions
10. Admin Dashboard (Web) – Campus operators monitor buses, analyze historical data, and optimize schedules.
-----------------------------------------------------------------------------------------------------------------------------------------
🎯 Impact

⏱ Saves time – reduces wasted waiting for full buses
😀Improves student experience – less stress, more reliable travel
🚌Optimizes campus mobility – smoother passenger distribution, safer rides
🌱Promotes sustainability – encourages public transport use over private cars
🏗 System Architecture
-----------------------------------------------------------------------------------------------------------------------------------------
Flow
Bus-side Hardware → IR Sensors, ESP32 MCU, GPS, Camera (optional)
⬇
Cloud Layer → Firebase (realtime DB), Kafka (streaming), AWS ML models & backend API
⬇
Applications → Mobile app (students) + Web dashboard (admins)
-----------------------------------------------------------------------------------------------------------------------------------------
🚀 Future Planning (Final)
Phase 1 - Continouous Development - Develop a MVPs that can runs in small-scale.

Phase 2 - Small-scale testing - Test & Improve the product

Phase 3 - Collaboration with the PIC - Seek for collaboration from UM to allow us to test it in real-world situation

Phase 4 - Campus Deployment - Officially deploy in 1 bus and further improvement will be made.
-----------------------------------------------------------------------------------------------------------------------------------------
🚀 Future Roadmap

Phase 1 – Campus Deployment – Pilot at UM with baseline data collection.

Phase 2 – Multi-campus Expansion – Extend to other universities.

Phase 3 – City Integration – Collaborate with public bus operators (e.g., RapidKL).

Phase 4 – Smart City Ecosystem – Integrate with smart parking, bike-sharing, EV shuttles, and CO₂ dashboards.
-----------------------------------------------------------------------------------------------------------------------------------------
Reference

"Files"
Firmware_code - Batch collection of data from hardware
my_app - FrontEnd
Google Map API/Google Flash 2.5 API/Firebase - in progress of obtaining/developing
ML_learning - In progress

Reference : https://drive.google.com/drive/folders/1LgEQi5m65OwLkbbaYzF4QKRDncZOUUc7?usp=sharing
-----------------------------------------------------------------------------------------------------------------------------------------
📜 License

This project is developed by Team Momocow (Chua Zhu Heng, Tey Yee Thong) for CodeNection.

“No more guessing, no more sardine buses — just smarter, smoother rides.”


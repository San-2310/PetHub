
# 🐾 PetHub – Integrated Pet Care & Health Management App

[![Flutter](https://img.shields.io/badge/Built%20with-Flutter-blue.svg)](https://flutter.dev)
[![Python](https://img.shields.io/badge/Backend-Python%20%7C%20Flask-yellow)](https://www.python.org)
[![License: MIT](https://img.shields.io/badge/license-MIT-green.svg)](https://opensource.org/licenses/MIT)

**👥 Team:** TechWizard  
**🏆 Event:** Manipal Hackathon 2024  
**💡 Track:** R4 - Integrated Pet Care Management and Health Tracking  
**🌍 SDG Goal:** SDG 3 – Good Health and Well-being  

---

## 📌 Overview

Pet owners often face fragmented tools for pet healthcare, nutrition, and tracking — leading to poor care outcomes. **PetHub** is a unified platform leveraging **QR Codes**, **ML**, and **GenAI** to make pet care intelligent, accessible, and delightful.

---

## 🚀 Features at a Glance

### 🧬 Health & Wellness

- **🔍 Pet Health Risk Analyzer**  
  → Input 5 symptoms  
  → KNN-based ML model calculates risk level  
  → Suggests veterinary action if needed

- **📋 QR Code Pet ID Tags**  
  → Unique codes on collars  
  → Enables access to pet info in emergencies  
  → Temporary vet access to medical records

- **👨‍🍳 Chef Woofles (Virtual Nutritionist)**  
  → Enter available ingredients  
  → AI generates pet-safe recipe with cooking instructions

---

### 🌎 Lifestyle & Convenience

- **🧳 Pet-Friendly Travel Planner**  
  → Enter destinations  
  → Web-scrapes real-time listings of pet-friendly hotels

- **📍 Grooming & Sitting Locator**  
  → Geolocation-powered discovery of groomers/sitters  
  → Map view, direct contact & booking

- **🌤️ WeatherBot**  
  → Breed recommendations based on local weather and space

---

### 📈 Extra Power Features

- **📊 Human Age Predictor for Pets**  
  → Converts breed & age to human years  
  → Offers care tips accordingly

- **🛍️ In-App E-Commerce**  
  → Buy pet accessories, food, QR tags  
  → Book vet consultations (₹199)

- **🧠 Community & Courses**  
  → Share posts, comment, like  
  → Vet-authored articles and awareness courses

---

## 📲 APK & Access

**📥 Download APK:**  
[Google Drive – App Debug APK](https://drive.google.com/file/d/1MS_Ig0wFUKY3ugZFI42FKdPkKnavav19/view?usp=sharing)

---

## ⚙️ Local Development Setup

### 🐍 Backend (Python 3.12 + Flask)

```bash
git clone https://github.com/ManipalHackathon2024/TechWizard.git
cd server/flask
pip install -r requirements.txt
python app.py
```
> Flask server runs at `http://127.0.0.1:8000`

---

### 💙 Frontend (Flutter App)

```bash
cd manipal_app
flutter pub get
```

#### 🔐 Create `.env` in `manipal_app/`:

```env
NEWS_API_KEY=your_news_api_key_here
STRIPE_API_KEY=your_stripe_api_key_here
BASE_URL=http://<your-ip>:8000
```

> Replace `<your-ip>` with your system IP or ngrok forwarding URL if using USB debugging.

---

### 🧪 Run App

```bash
flutter run
```

> Use Android emulator or USB-connected device.

#### ⚡ Ngrok for Remote Debugging (Optional)
```bash
ngrok config add-authtoken <your_auth_token>
ngrok http http://127.0.0.1:8000
```
Update `BASE_URL` in `.env` with your ngrok HTTPS URL.

---

## 💰 Monetization Strategy

| Stream                    | Details                          |
|--------------------------|----------------------------------|
| In-app purchases         | ₹49 – ₹299 (tags, accessories)   |
| Vet consultations        | ₹199 per booking                 |
| Product sales commission | 8% per sale                      |
| Custom sticker packs     | ₹19 – ₹29                        |

---

## 🛡️ Tech Stack

- **Frontend:** Flutter  
- **Backend:** Flask (Python)  
- **ML Models:** KNN (Symptom-based risk)  
- **Other Tools:** TensorFlow, Web Scraping, Ngrok, Firebase  

---

## 📚 References

- [Pet Obesity Management – Vet Clinics, 2021](https://doi.org/10.1016/j.cvsm.2021.01.009)  
- [Pet Travel Insights – THR, 2009](https://doi.org/10.1057/thr.2009.20)  
- [Clinical Mastitis Detection via ML – JDS, 2019](https://doi.org/10.3168/jds.2019-16610)  
- [Gamified Pet Wellbeing – IJSG, 2019](https://doi.org/10.17083/ijsg.v6i1.277)  

---

## 🐕‍🦺 Built With 💖 By Team TechWizard

- Sanjeev Ratnani  
- Heenal Patel  
- Muskan Sharma  
- Prathamesh Sanaye  

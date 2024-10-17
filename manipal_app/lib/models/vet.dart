class Doctor {
  final String name;
  final String specialty;
  final int yearsExperience;
  final String hospital;
  final String imageUrl;

  Doctor({
    required this.name,
    required this.specialty,
    required this.yearsExperience,
    required this.hospital,
    required this.imageUrl,
  });
}

final List<Doctor> doctorsList = [
  Doctor(
    name: "Dr. Rishi",
    specialty: "Cardiologist",
    yearsExperience: 5,
    hospital: "Seven Hills",
    imageUrl: "assets/doctors/doctor1.png",
  ),
  Doctor(
    name: "Dr. Vaamana",
    specialty: "Dentist",
    yearsExperience: 2,
    hospital: "Apollo",
    imageUrl: "assets/doctors/doctor2.png",
  ),
  Doctor(
    name: "Dr. Rishita",
    specialty: "Cardiologist",
    yearsExperience: 3,
    hospital: "Kokilaben",
    imageUrl: "assets/doctors/doctor3.png",
  ),
  Doctor(
    name: "Dr. Neerja",
    specialty: "Orthopaedic",
    yearsExperience: 6,
    hospital: "Cooper",
    imageUrl: "assets/doctors/doctor4.png",
  ),
  Doctor(
    name: "Dr. Ritesh",
    specialty: "Cardiologist",
    yearsExperience: 2,
    hospital: "Seven Hills",
    imageUrl: "assets/doctors/doctor3.png",
  ),
  Doctor(
    name: "Dr. Amelia",
    specialty: "Neurologist",
    yearsExperience: 8,
    hospital: "City Hospital",
    imageUrl: "assets/doctors/doctor1.png",
  ),
  Doctor(
    name: "Dr. Rajesh",
    specialty: "Pediatrician",
    yearsExperience: 4,
    hospital: "Children's Care",
    imageUrl: "assets/doctors/doctor2.png",
  ),
  Doctor(
    name: "Dr. Sophia",
    specialty: "Dermatologist",
    yearsExperience: 7,
    hospital: "Skin & Beauty Clinic",
    imageUrl: "assets/doctors/doctor3.png",
  ),
  Doctor(
    name: "Dr. Vikram",
    specialty: "Oncologist",
    yearsExperience: 10,
    hospital: "Cancer Care Institute",
    imageUrl: "assets/doctors/doctor4.png",
  ),
  Doctor(
    name: "Dr. Priya",
    specialty: "Gynecologist",
    yearsExperience: 6,
    hospital: "Women's Wellness Center",
    imageUrl: "assets/doctors/doctor1.png",
  ),
];
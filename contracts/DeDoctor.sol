// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract DeDoctor {
    uint doctorCount;
    uint pharmacyCount;
    uint patientCount;
    uint appointmentCount;

    struct DoctorProfile {
        uint doctorId;
        string name;
        string gender;
        string city;
        string language;
        uint price;
        string profileURI;
        address docAddress;
    }

    struct PhamacySturct {
        uint pharmacyId;
        string name;
        string city;
        string ownerName;
        address ownerAddress;
        string pharmacyNumber;
        string pharmacyUri;
    }

    struct PatientStruct {
        uint patientId;
        address walletAddress;
        string name;
        string gender;
        string city;
        string patientUri;
    }

    struct AppointmentStruct {
        uint appojntemtId;
        uint patientId;
        uint doctorId;
        string appointmentUri;
        string symptoms;
        string pastSymptoms;
        string date;
        string time;
        address walletAddress;
    }

    mapping(uint => DoctorProfile) doctors;
    mapping(uint => PhamacySturct) pharmacies;
    mapping(uint => PatientStruct) patients;
    mapping(uint => AppointmentStruct) appointments;

    event RegisteredDoctor(
        string indexed name,
        string gender,
        string indexed city,
        string indexed language,
        string profileURI,
        address docAddress
    );

    event RegsiteredPharmacy(
        string indexed name,
        string indexed city,
        string indexed ownerName,
        address ownerAddress,
        string pharmacyNumber,
        string pharmacyUri
    );

    function registerDoctor(
        string memory name,
        string memory gender,
        string memory city,
        string memory language,
        address docAddress,
        uint price,
        string memory profileURI
    ) public {
        doctorCount++;
        doctors[doctorCount].name = name;
        doctors[doctorCount].gender = gender;
        doctors[doctorCount].city = city;
        doctors[doctorCount].language = language;
        doctors[doctorCount].docAddress = docAddress;
        doctors[doctorCount].profileURI = profileURI;
        doctors[doctorCount].doctorId = doctorCount;
        doctors[doctorCount].price = price;
        emit RegisteredDoctor(
            name,
            gender,
            city,
            language,
            profileURI,
            docAddress
        );
    }

    function getDoctorById(
        uint doctorId
    ) public view returns (DoctorProfile memory) {
        return doctors[doctorId];
    }

    function getAllDoctors() public view returns (DoctorProfile[] memory) {
        DoctorProfile[] memory allDoctors = new DoctorProfile[](doctorCount);
        for (uint i = 0; i < doctorCount; i++) {
            DoctorProfile storage currentDoctor = doctors[i + 1];
            allDoctors[i] = currentDoctor;
        }
        return allDoctors;
    }

    function registerPharmacy(
        string memory name,
        string memory city,
        string memory ownerName,
        address ownerAddress,
        string memory pharmacyNumber,
        string memory pharmacyUri
    ) public returns (PhamacySturct memory) {
        pharmacyCount++;
        pharmacies[pharmacyCount].pharmacyId = pharmacyCount;
        pharmacies[pharmacyCount].name = name;
        pharmacies[pharmacyCount].city = city;
        pharmacies[pharmacyCount].ownerName = ownerName;
        pharmacies[pharmacyCount].ownerAddress = ownerAddress;
        pharmacies[pharmacyCount].pharmacyNumber = pharmacyNumber;
        pharmacies[pharmacyCount].pharmacyUri = pharmacyUri;

        emit RegsiteredPharmacy(
            name,
            city,
            ownerName,
            ownerAddress,
            pharmacyNumber,
            pharmacyUri
        );
        return pharmacies[pharmacyCount];
    }

    function registerPatient(
        string memory name,
        address walletAddress,
        string memory gender,
        string memory city,
        string memory patientUri
    ) public {
        patientCount++;
        patients[patientCount].patientId = patientCount;
        patients[patientCount].walletAddress = walletAddress;
        patients[patientCount].name = name;
        patients[patientCount].city = city;
        patients[patientCount].gender = gender;
        patients[patientCount].patientUri = patientUri;
    }

    function createAppoitment(
        uint patientId,
        uint doctorId,
        string memory symptoms,
        string memory pastSymptoms,
        string memory date,
        string memory time
    ) public {
        appointmentCount++;
        appointments[appointmentCount].appojntemtId = appointmentCount;
        appointments[appointmentCount].doctorId = doctorId;
        appointments[appointmentCount].patientId = patientId;
        appointments[appointmentCount].symptoms = symptoms;
        appointments[appointmentCount].pastSymptoms = pastSymptoms;
        appointments[appointmentCount].date = date;
        appointments[appointmentCount].time = time;
    }

    function getPharmacyById(
        uint pharmacyId
    ) public view returns (PhamacySturct memory) {
        return pharmacies[pharmacyId];
    }

    function getAllPharmacies() public view returns (PhamacySturct[] memory) {
        PhamacySturct[] memory allPharmacy = new PhamacySturct[](pharmacyCount);
        for (uint i = 0; i < doctorCount; i++) {
            PhamacySturct storage currentPharmacy = pharmacies[i + 1];
            allPharmacy[i] = currentPharmacy;
        }
        return allPharmacy;
    }

    function getPatientByWalletAddress(
        address walletAddress
    ) public view returns (PatientStruct memory) {
        for (uint i = 1; i <= patientCount; i++) {
            if (walletAddress == patients[i].walletAddress) {
                return patients[i];
            }
        }
        return patients[1];
    }

    function getDoctorByWalletAddress(
        address walletAddress
    ) public view returns (DoctorProfile memory) {
        for (uint i = 1; i <= patientCount; i++) {
            if (walletAddress == doctors[i].docAddress) {
                return doctors[i];
            }
        }
        return doctors[1];
    }

    function getAppimtmentsByDoctortId(
        uint doctorId
    ) public view returns (AppointmentStruct[] memory) {
        uint doctorAppointmentCount = 0;
        for (uint i = 1; i <= appointmentCount; i++) {
            if (doctorId == appointments[i].doctorId) {
                doctorAppointmentCount++;
            }
        }
        AppointmentStruct[]
            memory doctorAppointments = new AppointmentStruct[](
                doctorAppointmentCount
            );
        uint tempCount = 0;
        for (uint i = 0; i <= appointmentCount; i++) {
            if (doctorId == appointments[i].doctorId) {
                AppointmentStruct storage currentAppointment = appointments[
                    i + 1
                ];
                doctorAppointments[tempCount] = currentAppointment;
                tempCount++;
            }
        }
        return doctorAppointments;
    }

    function getAppimtmentsByPatientId(
        uint patientId
    ) public view returns (AppointmentStruct[] memory) {
        uint patientAppointmentCount = 0;
        for (uint i = 1; i <= appointmentCount; i++) {
            if (patientId == appointments[i].patientId) {
                patientAppointmentCount++;
            }
        }
        AppointmentStruct[]
            memory patientAppointments = new AppointmentStruct[](
                patientAppointmentCount
            );
        uint tempCount = 0;
        for (uint i = 0; i <= appointmentCount; i++) {
            if (patientId == appointments[i].patientId) {
                AppointmentStruct storage currentAppointment = appointments[
                    i + 1
                ];
                patientAppointments[tempCount] = currentAppointment;
                tempCount++;
            }
        }
        return patientAppointments;
    }
}

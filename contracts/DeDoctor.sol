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

    struct Pharmacy {
        uint id;
        string name;
        string city;
        string ownerName;
        address ownerAddress;
        string number;
        string uri;
    }

    struct Patient {
        uint patientId;
        address walletAddress;
        string name;
        string gender;
        string city;
        string patientUri;
    }

    struct Appointment {
        uint256 id;
        uint256 patientId;
        uint256 doctorId;
        string appointmentUri;
        string symptoms;
        string pastSymptoms;
        string date;
        string time;
        address walletAddress;
    }

    mapping(uint => DoctorProfile) doctors;
    mapping(uint => Pharmacy) public pharmacies;
    mapping(uint => Patient) patients;

    mapping(uint256 => Appointment) private appointmentRecords;
    mapping(uint256 => Appointment[]) private appointmentsByPatientId;
    mapping(uint256 => Appointment[]) private appointmentsByDoctorId;

    event AppointmentCreated(
        uint256 indexed id,
        uint256 indexed patientId,
        uint256 indexed doctorId,
        string symptoms,
        string pastSymptoms,
        string date,
        string time,
        address walletAddress
    );

    event RegisteredDoctor(
        string indexed name,
        string gender,
        string indexed city,
        string indexed language,
        string profileURI,
        address docAddress
    );

    event RegisteredPharmacy(
        string indexed name,
        string indexed city,
        string indexed ownerName,
        address ownerAddress,
        string number,
        string uri
    );

    event PatientRegistered(
        uint indexed patientId,
        address indexed walletAddress,
        string name,
        string gender,
        string city,
        string patientUri
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
        doctors[doctorCount] = DoctorProfile({
            doctorId: doctorCount,
            name: name,
            gender: gender,
            city: city,
            language: language,
            price: price,
            profileURI: profileURI,
            docAddress: docAddress
        });
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
            allDoctors[i] = doctors[i + 1];
        }
        return allDoctors;
    }

    function registerPharmacy(
        string memory name,
        string memory city,
        string memory ownerName,
        address ownerAddress,
        string memory number,
        string memory uri
    ) public returns (Pharmacy memory) {
        pharmacyCount++;
        pharmacies[pharmacyCount] = Pharmacy({
            id: pharmacyCount,
            name: name,
            city: city,
            ownerName: ownerName,
            ownerAddress: ownerAddress,
            number: number,
            uri: uri
        });

        emit RegisteredPharmacy(
            name,
            city,
            ownerName,
            ownerAddress,
            number,
            uri
        );
        return pharmacies[pharmacyCount];
    }

    function registerPatient(
        string memory name,
        address walletAddress,
        string memory gender,
        string memory city,
        string memory patientUri
    ) public returns (uint) {
        for (uint i = 1; i <= patientCount; i++) {
            require(
                patients[i].walletAddress != walletAddress,
                "Patient already exists"
            );
        }

        patientCount++;
        patients[patientCount] = Patient({
            patientId: patientCount,
            walletAddress: walletAddress,
            name: name,
            gender: gender,
            city: city,
            patientUri: patientUri
        });

        emit PatientRegistered(
            patientCount,
            walletAddress,
            name,
            gender,
            city,
            patientUri
        );

        return patientCount;
    }

    function createAppointment(
        uint256 patientId,
        uint256 doctorId,
        string memory symptoms,
        string memory pastSymptoms,
        string memory date,
        string memory time
    ) public {
        appointmentCount++;
        appointmentRecords[appointmentCount] = Appointment({
            id: appointmentCount,
            patientId: patientId,
            doctorId: doctorId,
            appointmentUri: "",
            symptoms: symptoms,
            pastSymptoms: pastSymptoms,
            date: date,
            time: time,
            walletAddress: msg.sender
        });
        appointmentsByPatientId[patientId].push(
            appointmentRecords[appointmentCount]
        );
        appointmentsByDoctorId[doctorId].push(
            appointmentRecords[appointmentCount]
        );

        emit AppointmentCreated(
            appointmentCount,
            patientId,
            doctorId,
            symptoms,
            pastSymptoms,
            date,
            time,
            msg.sender
        );
    }

    function getPharmacyById(
        uint pharmacyId
    ) public view returns (Pharmacy memory) {
        return pharmacies[pharmacyId];
    }

    function getAllPharmacies() public view returns (Pharmacy[] memory) {
        Pharmacy[] memory allPharmacies = new Pharmacy[](pharmacyCount);
        for (uint i = 1; i <= pharmacyCount; i++) {
            allPharmacies[i - 1] = pharmacies[i];
        }
        return allPharmacies;
    }

    function getPatientByWalletAddress(
        address walletAddress
    ) public view returns (Patient memory) {
        for (uint i = 1; i <= patientCount; i++) {
            if (patients[i].walletAddress == walletAddress) {
                return patients[i];
            }
        }
        revert("Patient not found");
    }

    function getDoctorByWalletAddress(
        address walletAddress
    ) public view returns (DoctorProfile memory) {
        for (uint i = 1; i <= doctorCount; i++) {
            if (walletAddress == doctors[i].docAddress) {
                return doctors[i];
            }
        }
        revert("No doctor found for the given wallet address");
    }

    function getAppointmentsByDoctorId(
        uint256 doctorId
    ) public view returns (Appointment[] memory) {
        return appointmentsByDoctorId[doctorId];
    }

    function getAppointmentsByPatientId(
        uint256 patientId
    ) public view returns (Appointment[] memory) {
        return appointmentsByPatientId[patientId];
    }
}

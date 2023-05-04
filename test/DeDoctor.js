const { expect } = require("chai");

describe("DeDoctor", function () {
  let deDoctor;
  let owner;
  let doctor1;
  let doctor2;

  beforeEach(async function () {
    const DeDoctor = await hre.ethers.getContractFactory("DeDoctor");
    deDoctor = await DeDoctor.deploy();
    await deDoctor.deployed();

    [owner, doctor1, doctor2] = await hre.ethers.getSigners();
  });

  describe("registerDoctor", function () {
    it("should emit RegisteredDoctor event", async function () {
      const name = "Dr. John Doe";
      const gender = "Male";
      const city = "New York";
      const language = "English";
      const price = ethers.utils.parseEther("1");
      const profileURI = "https://example.com/profile";

      const tx = await deDoctor.registerDoctor(
        name,
        gender,
        city,
        language,
        doctor1.address,
        price,
        profileURI
      );
      await expect(tx)
        .to.emit(deDoctor, "RegisteredDoctor")
        .withArgs(name, gender, city, language, profileURI, doctor1.address);
    });
  });

  describe("getDoctorById", function () {
    it("should return correct doctor profile", async function () {
      const name = "Dr. John Doe";
      const gender = "Male";
      const city = "New York";
      const language = "English";
      const price = ethers.utils.parseEther("1");
      const profileURI = "https://example.com/profile";

      await deDoctor.registerDoctor(
        name,
        gender,
        city,
        language,
        doctor1.address,
        price,
        profileURI
      );
      const doctorProfile = await deDoctor.getDoctorById(1);
      expect(doctorProfile.doctorId).to.equal(1);
      expect(doctorProfile.name).to.equal(name);
      expect(doctorProfile.gender).to.equal(gender);
      expect(doctorProfile.city).to.equal(city);
      expect(doctorProfile.language).to.equal(language);
      expect(doctorProfile.price).to.equal(price);
      expect(doctorProfile.profileURI).to.equal(profileURI);
      expect(doctorProfile.docAddress).to.equal(doctor1.address);
    });
  });

  describe("getAllDoctors", function () {
    it("should return an empty array for no registered doctors", async function () {
      const allDoctors = await deDoctor.getAllDoctors();

      expect(allDoctors).to.be.an("array").that.is.empty;
    });
    it("should return an array of registered doctors", async function () {
      const name = "John Doe";
      const gender = "Male";
      const city = "New York";
      const language = "English";
      const price = ethers.utils.parseEther("1");
      const profileURI = "https://example.com/profile";
      const docAddress = owner.address;

      await deDoctor.registerDoctor(
        name,
        gender,
        city,
        language,
        docAddress,
        price,
        profileURI
      );

      const allDoctors = await deDoctor.getAllDoctors();

      expect(allDoctors).to.be.an("array").that.has.lengthOf(1);

    //   expect(allDoctors[0]).to.deep.include({
    //     name: name,
    //     gender: gender,
    //     city: city,
    //     language: language,
    //     price: price,
    //     profileURI: profileURI,
    //     docAddress: docAddress,
    //   });
    });
  });
});

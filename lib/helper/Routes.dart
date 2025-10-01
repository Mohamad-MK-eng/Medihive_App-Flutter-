import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medihive_1_/cubits/cubit/pat_wallet_cubit.dart';
import 'package:medihive_1_/models/Arguments_Models/App_success_info.dart';
import 'package:medihive_1_/models/Arguments_Models/final_docot_payment_date_info.dart';
import 'package:medihive_1_/models/Clinic.dart';
import 'package:medihive_1_/models/Doctor.dart';
import 'package:medihive_1_/models/DoctorAppointment.dart';
import 'package:medihive_1_/models/Prescription.dart';
import 'package:medihive_1_/pages/Auth/view/Login_Page.dart';
import 'package:medihive_1_/pages/Auth/view/Register_page.dart';
import 'package:medihive_1_/pages/Ip_determination_page.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/cubit/doc_patient_cubit_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/views/Doctor_Patients_page.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/views/Patient_infor_Page.dart';
import 'package:medihive_1_/pages/User_Doctor/Doctor_Patients/views/Patients_Records_Page.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/cubit/doctor_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/views/Change_Password.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/views/Doc_Home_Page.dart';
import 'package:medihive_1_/pages/User_Doctor/Home/views/Doctor_Profile_Page.dart';
import 'package:medihive_1_/pages/User_Doctor/Prescriptions/views/Add_Report_Page.dart';
import 'package:medihive_1_/pages/User_Patient/Home/views/About_Us_Page.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/cubit/medical_history_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/views/Medical_History_Page.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/views/Patient_Medical_Recored.dart';
import 'package:medihive_1_/pages/OnBoarding/OnBoarding.dart';
import 'package:medihive_1_/pages/SplashScreen.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/appointment_date_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/cubit/my_appointment_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/App_Confirmation_Page.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/Appointments_Page.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/Cancel_Appointment.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/Date_Time_Selection.dart';
import 'package:medihive_1_/pages/User_Patient/Appointement_all/views/Payment_Page.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/cubit/doctor_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/views/ClinicDotors.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/views/DoctorDetails.dart';
import 'package:medihive_1_/pages/User_Patient/DoctorPages/views/Top_Doctors_page.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/Clinic/Clinic_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/Patient_Search/search_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/cubit/cubit/top_doctors_cubit.dart';
import 'package:medihive_1_/pages/User_Patient/Home/views/ClinicsPage.dart';
import 'package:medihive_1_/pages/User_Patient/Home/views/HomePage.dart';
import 'package:medihive_1_/pages/User_Patient/Home/views/Search_Page.dart';
import 'package:medihive_1_/pages/User_Patient/Medical_History/views/Prescreption_Page.dart';
import 'package:medihive_1_/pages/User_Patient/profile/view/ProfilePage.dart';

const String secretaryName = 'Lisa Adam';

class Routes {
  static const String ipPage = '/';
  static const String splashScreen = '/splash';

  static const String onBoardings = '/onBoarding';

  static const String loginPage = '/login';

  static const String registerPage = '/register';

  // patient application
  static const String patientHome = '/patientHome';

  static const String clinicInfoPage = '/patientHome/aboutUs';

  static const String clinicsPage = '/patientHome/clinics';

  static const String doctorClinicPage = '/patientHome/clinics/doctors';

  static const String doctorDetailsPage =
      '/patientHome/clinics/doctors/details';

  static const String topDoctorsPage = '/patientHome/topDoctors';

  static const String profilePage = '/profile';

  static const String patientSearchPage = '/patientHome/search';

  static const String dateAndTimeSelectionPage =
      '/patientHome/clinics/doctors/doctor/selectdate';

  static const String paymentPage =
      '/patientHome/clinics/doctors/doctor/selectdate/payment';
  static const String appConfirmationPage =
      '/patientHome/clinics/doctors/doctor/selectdate/payment/lastPage';
  static const String appointmentsPage = '/appointments';
  static const String cancelAppointmetPage = '/appointments/cancel';
  static const String medicalHistoryPage = '/medicalHistory';
  static const String patSelectedRecordPage = '/medicalHistory/Record';
  static const String prescriptionPage = '/medicalHistory/Record/prescription';
  // doctor Pages doctor Pages doctor Pages doctor Pages
  static const String doctor_home_page = '/docHome';
  static const String doctor_ChangePassword = '/docHome/change_pass';
  static const String doctor_ProfilePage = '/docHome/Profile';
  static const String doctor_patients_page = '/docHome/docPatients';
  static const String patient_info_page = '/docHome/docPatients/patient_info';
  static const String patient_records_page =
      '/docHome/docPatients/patient_records';
  static const String addReportPage = '/docHome/addReport';

  static Route<dynamic> onGernerateRoute(RouteSettings setting) {
    var argument = setting.arguments;

    switch (setting.name) {
      case splashScreen:
        {
          return MaterialPageRoute(builder: (_) => SplashScreen());
        }
      case onBoardings:
        {
          return MaterialPageRoute(builder: (_) => OnboardingScreens());
        }
      case loginPage:
        {
          return MaterialPageRoute(builder: (_) => LoginPage());
        }
      case registerPage:
        {
          return MaterialPageRoute(builder: (_) => RegisterPage());
        }
      // Patient Application
      case patientHome:
        {
          return MaterialPageRoute(
            settings: RouteSettings(name: setting.name),
            builder: (_) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (_) => ClinicCubit()),
                BlocProvider(
                  create: (_) => TopDoctorsCubit(),
                ),
              ],
              child: PatientHome(), // التابع بينادى من داخل الصفحة
            ),
          );
        }
      case clinicInfoPage:
        {
          return MaterialPageRoute(builder: (_) => AboutUsPage());
        }
      case clinicsPage:
        {
          return MaterialPageRoute(
              builder: (_) => Clinicspage(
                    clinic: argument as List<Clinic>,
                  ));
        }

      case doctorClinicPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => DoctorCubit(),
                    child: ClinicDoctors(
                        attributes: argument as Map<String, dynamic>),
                  ));
        }
      case doctorDetailsPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => DoctorCubit(),
                    child: DoctordetailsPage(
                      doctor: argument as Doctor,
                    ),
                  ));
        }
      case topDoctorsPage:
        {
          return MaterialPageRoute(
              builder: (_) =>
                  TopDoctorsPage(topDoctors: argument as List<Doctor>));
        }
      case patientSearchPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => PatientSearchCubit(),
                    child: SearchPage(),
                  ));
        }
      case profilePage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => PatWalletCubit(),
                    child: Profilepage(
                      // مبدئيا
                      initialIndex: argument == null ? 0 : argument as int,
                    ),
                  ));
        }
      case dateAndTimeSelectionPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (_) => AppointmentDateCubit(),
                    child: DateTimeSelection(
                      doctorId_doctorFee: argument as Map<String, dynamic>,
                    ),
                  ));
        }
      case paymentPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => PatWalletCubit(),
                    child: PaymentPage(
                      info: argument as FinalDocotPaymentDateInfo,
                    ),
                  ));
        }
      case appConfirmationPage:
        {
          return MaterialPageRoute(
              builder: (_) => AppConfirmationPage(
                    successInfo: argument as AppSuccessInfo,
                  ));
        }
      case appointmentsPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (_) => MyAppointmentCubit(),
                    child: AppointmentsPage(),
                  ));
        }
      case cancelAppointmetPage:
        {
          final data = argument as Map<String, dynamic>;
          final mycubit = data['cubit'] as MyAppointmentCubit;
          final appointment_id = data['appointment_id'] as int;
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: mycubit,
                    child:
                        CancelAppointmentPage(appointment_id: appointment_id),
                  ));
        }
      case patSelectedRecordPage:
        {
          final data = argument as Map<String, dynamic>;
          int appointment_id = data['appointment_id'] as int;
          String? patient_name = data['patient_name'] as String?;
          String? type = data['type'] as String?;
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (_) => MedicalHistoryCubit(),
                    child: PatientMedicalRecored(
                      appointment_id: appointment_id,
                      patient_name: patient_name,
                      type: type,
                    ),
                  ));
        }
      case medicalHistoryPage:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (_) => MedicalHistoryCubit(),
                    child: MedicalHistoryPage(
                      clinics: argument as List<Clinic>,
                    ),
                  ));
        }
      case prescriptionPage:
        {
          return MaterialPageRoute(
              builder: (_) => PrescriptionPage(
                    dataList: argument as List<Prescription>,
                  ));
        }

      /// docotrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrdoctorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr
      case doctor_home_page:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => DoctorAppointmentCubit(),
                    child: DocHomePage(),
                  ));
        }
      case doctor_ProfilePage:
        {
          return MaterialPageRoute(builder: (_) => DoctorProfilePage());
        }
      case doctor_ChangePassword:
        {
          return MaterialPageRoute(builder: (_) => ChangePasswordPage());
        }
      case doctor_patients_page:
        {
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => DocPatientCubit(),
                    child: DoctorPatientsPage(),
                  ));
        }
      case patient_records_page:
        {
          final data = argument as Map<String, dynamic>;
          int patient_id = data['patient_id'] as int;
          String patient_name = data['patient_name'];
          return MaterialPageRoute(
              builder: (_) => BlocProvider(
                    create: (context) => DocPatientCubit(),
                    child: PatientsRecordsPage(
                      patient_id: patient_id,
                      patient_name: patient_name,
                    ),
                  ));
        }
      case patient_info_page:
        {
          int patient_id = argument as int;
          return MaterialPageRoute(
              builder: (_) => PatientInfoPage(
                    patient_id: patient_id,
                  ));
        }
      case addReportPage:
        {
          final data = argument as Map<String, dynamic>;
          final myCubit = data['cubit'] as DoctorAppointmentCubit;
          final data_index = data['index'] as int;
          final appointment = data['appointment'] as Doctorappointment;
          return MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                    value: myCubit,
                    child: AddReportPage(
                      appointment: appointment,
                      appointment_index: data_index,
                    ),
                  ));
        }
    }
    return MaterialPageRoute(builder: (_) => IpDeterminationPage());
  }
}

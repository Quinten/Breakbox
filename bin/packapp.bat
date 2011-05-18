@echo off

::adt -package -target [ipa-test ipa-debug ipa-app-store ipa-ad-hoc] -provisioning-profile PROFILE_PATH SIGNING_OPTIONS [-connect IP] TARGET_IPA_FILE APP_DESCRIPTOR SOURCE_FILES

:: device testing
PATH_TO\flex_4.5\bin\adt -package -target ipa-test -provisioning-profile PATH_TO\myapp_breakbox_test.mobileprovision -storetype pkcs12 -keystore PATH_TO\my_iphone_dev_cert.p12 -storepass MY_PASSWORD myapp.ipa application.xml myswf.swf icons Default.png


:: app store
::PATH_TO\flex_4.5\bin\adt -package -target ipa-app-store -provisioning-profile PATH_TO\myapp_appstore.mobileprovision -storetype pkcs12 -keystore PATH_TO\my_iphone_distr_cert.p12 -storepass MY_PASSWORD myapp.ipa application.xml myswf.swf icons Default.png
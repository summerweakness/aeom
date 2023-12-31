set(ldap_common_SOURCES
	LdapBrowseDialog.cpp
	LdapBrowseDialog.ui
	LdapBrowseDialog.h
	LdapBrowseModel.cpp
	LdapBrowseModel.h
	LdapClient.cpp
	LdapClient.h
	LdapConfiguration.cpp
	LdapConfiguration.h
	LdapConfigurationPage.h
	LdapConfigurationPage.cpp
	LdapConfigurationPage.ui
	LdapConfigurationTest.h
	LdapConfigurationTest.cpp
	LdapDirectory.cpp
	LdapDirectory.h
	LdapNetworkObjectDirectory.cpp
	LdapNetworkObjectDirectory.h
	LdapNetworkObjectDirectoryConfigurationPage.h
	LdapNetworkObjectDirectoryConfigurationPage.cpp
	LdapNetworkObjectDirectoryConfigurationPage.ui
	ldap.qrc
	)

add_library(ldap-common SHARED ${ldap_common_SOURCES})
target_include_directories(ldap-common PRIVATE ${CMAKE_CURRENT_BINARY_DIR} ${Ldap_INCLUDE_DIRS})
target_include_directories(ldap-common PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(ldap-common PRIVATE kldap-light veyon-core)
set_default_target_properties(ldap-common)
if(WITH_PCH)
	target_precompile_headers(ldap-common REUSE_FROM veyon-library-pch)
endif()
if(NOT WITH_CORE_ONLY)
	install(TARGETS ldap-common DESTINATION ${VEYON_LIB_DIR})
endif()

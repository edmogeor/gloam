# Standalone build for the patched lookandfeelautoswitcher KDED module.
# Only needs the module's direct dependencies, not the full plasma-workspace tree.

cmake_minimum_required(VERSION 3.16)
project(lookandfeelautoswitcher-patch)

find_package(ECM 6.0.0 REQUIRED NO_MODULE)
set(CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

include(KDEInstallDirs)
include(KDECMakeSettings)
include(KDECompilerSettings NO_POLICY_SCOPE)
include(ECMQtDeclareLoggingCategory)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(QT_DEFAULT_MAJOR_VERSION 6)
find_package(Qt6 REQUIRED COMPONENTS Core)
find_package(KF6 REQUIRED COMPONENTS Config CoreAddons DBusAddons IdleTime Package Service)
find_package(KNightTime REQUIRED)
find_package(LibKLookAndFeel REQUIRED)

kcoreaddons_add_plugin(lookandfeelautoswitcher INSTALL_NAMESPACE "kf6/kded")

target_sources(lookandfeelautoswitcher PRIVATE
    idletimeout.cpp
    lookandfeelautoswitcher.cpp
)

ecm_qt_declare_logging_category(lookandfeelautoswitcher
    HEADER logging.h
    IDENTIFIER LOOKANDFEELAUTOSWITCHER
    CATEGORY_NAME org.kde.plasma.lookandfeelautoswitcher
    DESCRIPTION "look-and-feel autoswitcher"
    DEFAULT_SEVERITY Warning
)

kconfig_target_kcfg_file(lookandfeelautoswitcher
    FILE ${CMAKE_CURRENT_SOURCE_DIR}/lookandfeelsettings.kcfg
    CLASS_NAME LookAndFeelSettings
    MUTATORS
)

kconfig_target_kcfg_file(lookandfeelautoswitcher
    FILE ${CMAKE_CURRENT_SOURCE_DIR}/lookandfeelautoswitcherstate.kcfg
    CLASS_NAME LookAndFeelAutoSwitcherState
    MUTATORS
)

target_link_libraries(lookandfeelautoswitcher PRIVATE
    Qt6::Core
    KF6::ConfigCore
    KF6::ConfigGui
    KF6::CoreAddons
    KF6::DBusAddons
    KF6::IdleTime
    PW::KLookAndFeel
    KNightTime
)

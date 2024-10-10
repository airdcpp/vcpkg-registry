vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO miniupnp/libnatpmp
    REF 8257134a5dcb077e40db1946554d676e444406e4
    SHA512 eb277a2507d658d5f5b8af4af44b80eabdd9ea460c498f736c2e6417dd1026994916cdafb0aaf31c0687cec38abe6abfd9179a5afe2c3c87d2203564db88b97a
    HEAD_REF master
    PATCHES
      fix-vcpkg-install.patch
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_SHARED_LIBS)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBS}
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

# vcpkg_cmake_config_fixup(CONFIG_PATH "/lib/cmake/${PORT}")
# vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/natpmp PACKAGE_NAME natpmp)

vcpkg_fixup_pkgconfig()
# vcpkg_cmake_config_fixup()
vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/natpmp)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/bin" "${CURRENT_PACKAGES_DIR}/debug/bin")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
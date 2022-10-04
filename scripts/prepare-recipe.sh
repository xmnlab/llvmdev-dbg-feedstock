#!/usr/bin/env bash

set -ex

mkdir -p recipe
rm -rf recipe/*

mkdir -p recipe/patches

RECIPE_URL=https://raw.githubusercontent.com/conda-forge/llvmdev-feedstock/main/recipe
RECIPE_FILES="bld.bat build.sh conda_build_config.yaml install_llvm.bat install_llvm.sh meta.yaml numba-3016.ll"
PATCH_FILES="0001-pass-through-QEMU_LD_PREFIX-SDKROOT.patch amd-roc-2.7.0.diff expect-fastmath-entrypoints-in-add-TLI-mappings.ll.patch intel-D47188-svml-VF.patch"

pushd recipe
for file in ${RECIPE_FILES}; do
  wget "${RECIPE_URL}/${file}"
done

pushd patches
for file in ${PATCH_FILES}; do
  wget "${RECIPE_URL}/patches/${file}"
done
popd

sed -i "s|Release|Debug|" build.sh
sed -i "s|Release|Debug|" bld.bat

popd

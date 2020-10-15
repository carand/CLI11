CMAKE = cmake
#Switch to activatad Build Type
BUILD_TYPE=Debug
# BUILD_TYPE=Release
# BUILD_TYPE=RelWithDebInfo
# BUILD_TYPE=MinSizeRel
RELEASE_DIR=./INSTALL_DIR
CMAKE_BUILD_DIR= build
APP_NAME=CLI11
# Switch to your prefered build tool.
BUILD_TOOL = "Unix Makefiles"
# BUILD_TOOL = "CodeBlocks - Unix Makefiles"
# BUILD_TOOL = "Eclipse CDT4 - Unix Makefiles"

# -DCMAKE_BUILD_TYPE=Debug -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=TRUE -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j3 -DCMAKE_ECLIPSE_VERSION=4.1

CMAKE_OPTIONS :=  \
	-DCLI11_BUILD_TESTS=OFF \
	-DCLI11_BUILD_TESTS=OFF \
	-DCLI11_BUILD_EXAMPLES=OFF \
	-DCLI11_BUILD_DOCS=OFF \
	-DCMAKE_CXX_FLAGS="-m32"



default: install


$(CMAKE_BUILD_DIR): generate_build_tool

install: | $(CMAKE_BUILD_DIR)
	 $(MAKE) -C $(CMAKE_BUILD_DIR) install



release:
	$(CMAKE) -H. -BRelease -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles"  \
	$(CMAKE_OPTIONS)
	$(MAKE) -C Release $(APP_NAME)


install_release: distclean
	$(CMAKE) -H. -BRelease -DCMAKE_BUILD_TYPE=Release -G "Unix Makefiles"  \
	$(CMAKE_OPTIONS) \
	-DCMAKE_INSTALL_PREFIX:PATH=$(RELEASE_DIR)
	$(MAKE) -C Release install



generate_build_tool:
	$(CMAKE) -H. -B$(CMAKE_BUILD_DIR) -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) -G $(BUILD_TOOL) \
		$(CMAKE_OPTIONS)








clean:
	$(RM) -r tags
	$(RM) -r cscope.out
	cd $(CMAKE_BUILD_DIR) &&  $(MAKE) clean $(ARGS); cd ..
	# $(MAKE) -C $(CMAKE_BUILD_DIR) clean




.PHONY: distclean
distclean:  clean
	$(RM) -r $(CMAKE_BUILD_DIR)
	$(RM) -r Release
	$(RM) -r Debug
	$(RM) -r CodeblocksDebug
	$(RM) -r CodeblocksRelease
	$(RM) tags
	$(RM) cscope.out
	$(RM) cscope.out.*
	$(RM) *.orig
	$(RM) ncscope.out.*


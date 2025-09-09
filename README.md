# Neovim Java Configuration

This is a Neovim configuration specifically for Java development.

## Local Dependencies

The configuration now includes local dependencies:

- `deps/lombok.jar`: Project Lombok jar for annotation processing
- `deps/debug/*.jar`: Java debugging and testing support bundles

These dependencies are included in the repository to make it portable across different systems.

## Configuration

The main Java configuration is in `ftplugin/java.lua`. It uses:

1. Java JDK installed via SDKMAN
2. Local Lombok jar
3. JDTLS installed via Homebrew
4. Local Java debugging bundles

If you need to update any dependencies, replace the files in the `deps` directory.

# Sometimes JDTLS can be very picky how it needs certain things
* Generated sources have to be directly in the output folder. 
	This means that target/generated-sources/src/main/java/<packages> is NOT good.
	It should be target/generated-sources/<packages>
	This can be fixed for the openapi-generator-maven-plugin, using the java generator, by adding underlying to the `<configuration>` of the plugin:
	```xml
	<configOptions>
	<sourceFolder>.</sourceFolder>
	```
* Plugins, such as the `openapi-generator-maven-plugin` when causing troubles, should be added to the `<pluginManagement>` part of the parent pom!

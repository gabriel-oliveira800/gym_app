import com.android.build.gradle.BaseExtension

allprojects {
    repositories {
        google()
        mavenCentral()
    }

    subprojects {
        afterEvaluate {
            if (plugins.hasPlugin("com.android.library") || plugins.hasPlugin("com.android.application")) {
                extensions.findByName("android")?.let { ext ->
                    val android = ext as? BaseExtension
                    android?.let {
                        if (it.namespace.isNullOrBlank()) {
                            val defaultNamespace = group.toString()
                            it.namespace = defaultNamespace
                            println("Namespace não definido para $name, usando padrão: $defaultNamespace")
                        }
                    }
                }
            }
        }
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

package me.kcybulski.leeho.domain

import java.lang.RuntimeException

class Crew(val crew: Set<CrewMan>) {

    fun readyAbout(maneuver: Maneuver) {
        crew.forEach { it.readyAbout(maneuver) }
    }

    inline fun <reified T : CrewMan> command(command: T.() -> Answer): Answer =
        command((crew.find { it is T  } ?: throw CrewManNotFoundException()) as T)

    class CrewManNotFoundException() : RuntimeException("Crewman not found")

}

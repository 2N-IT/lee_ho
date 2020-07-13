package me.kcybulski.leeho.domain

import me.kcybulski.leeho.domain.Answer.YO

open class CrewMan(val name: String) {

    fun readyAbout(maneuver: Maneuver): Answer = YO.also { shout("Jest do ${maneuver.maneuverName}") }

    protected fun shout(message: String) = println("$name: $message!")

}

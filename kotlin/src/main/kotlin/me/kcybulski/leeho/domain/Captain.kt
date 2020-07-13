package me.kcybulski.leeho.domain

import me.kcybulski.leeho.domain.Maneuver.LEE_HO

class Captain(name: String, private val crew: Crew) : CrewMan(name) {

    fun leeHo() {
        shout("Do zwrotu przez sztag")
        crew.readyAbout(LEE_HO)

        command<SteerMan>("Ster prawo") { right() }
        command<MizzenSheetMan>("Bezana szot wybierz") { haul() }
        command<MainsailSheetMan>("Grota szot wybierz") { haul() }
        command<LeftJibSheetMan>("Lewy foka szot luz") { release() }
        command<MainsailSheetMan>("Grota szot luz") { release() }
        command<MizzenSheetMan>("Bezana szot luz") { release() }
        command<RightJibSheetMan>("Prawy foka szot wybieraj") { pull() }
        command<MainsailSheetMan>("Grota szot wybieraj") { pull() }
        command<MizzenSheetMan>("Bezana szot wybieraj") { pull() }
        command<SteerMan>("Sternik tak trzymaj") { keep() }
    }

    private inline fun <reified T: CrewMan> command(message: String, command: T.() -> Answer): Answer {
        shout(message)
        return crew.command<T>(command)
    }

}

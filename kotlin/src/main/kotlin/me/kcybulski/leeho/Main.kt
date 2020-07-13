package me.kcybulski.leeho

import me.kcybulski.leeho.domain.*
import me.kcybulski.leeho.infrastructure.GreatCoach

fun main() {

    val yacht = GreatCoach()
    val crew = Crew(setOf(
        SteerMan(yacht.steer, "Bob"),
        LeftJibSheetMan(yacht.leftJibSheet, "Marco"),
        RightJibSheetMan(yacht.rightJibSheet, "Terry"),
        MainsailSheetMan(yacht.mainsailSheet, "Arthur"),
        MizzenSheetMan(yacht.mizzenSheet, "Jake"),
        CrewMan("Adam")
    ))

    val captain = Captain("Sparrow", crew)
    captain.leeHo()

}

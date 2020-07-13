package me.kcybulski.leeho.infrastructure

import me.kcybulski.leeho.domain.*

class GreatCoach: Yacht {

    val jibSail = JibSail()
    val mainsailSail = MainsailSail()
    val mizzenSail = MizzenSail()

    val leftJibSheet = LeftJibSheet(jibSail)
    val rightJibSheet = RightJibSheet(jibSail)
    val mainsailSheet = MainsailSheet(mainsailSail)
    val mizzenSheet = MizzenSheet(mizzenSail)

    val steer = Steer()

    override fun sheets(): Set<Sheet> = setOf(leftJibSheet, rightJibSheet, mainsailSheet, mizzenSheet)

    override fun steer(): Steer = steer


}

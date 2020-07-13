package me.kcybulski.leeho.domain

import me.kcybulski.leeho.domain.Answer.YO

class SteerMan(val steer: Steer, name: String) : CrewMan(name) {

    fun keep(): Answer = YO
        .also { shout("Jest trzymaj kurs") }
        .also { steer.setPosition(0.0) }

    fun left(): Answer = YO
        .also { shout("Jest ster lewo") }
        .also { steer.setPosition(-1.0) }

    fun right(): Answer = YO
        .also { shout("Jest ster prawo") }
        .also { steer.setPosition(1.0) }

}

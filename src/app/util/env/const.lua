------------------------------------------------------------
-- development environment constants
-- 开发环境参数
--

----------------------------------------------
-- DEBUG BEGAN

local __DEBUG__ = {
    SHOW_FPS = true,
    DUMP_LOG = true,
    SAVE_LOG = true,
}

-- DEBUG ENDED
----------------------------------------------


----------------------------------------------
-- RELEASE BEGAN

local __RELEASE__ = {
    SHOW_FPS = false,
    DUMP_LOG = false,
    SAVE_LOG = false,
}

-- RELEASE ENDED
----------------------------------------------


----------------------------------------------
-- COMMON BEGAN

local __COMMON__ = {
    HIGH_FPS  = 60,
    MID_FPS   = 52,
    LOW_FPS   = 44,
    PACKAGEID = 1,
}

-- COMMON ENDED
----------------------------------------------


----------------------------------------------
-- 1. CG : Custom Global Variable's Prefix
-- 2. CGGetEnv : 获得开发模式下的环境变量参数
--
return {
    MODE    = 'DEBUG', -- 开发模式 : 'DEBUG' | 'RELEASE' 
    DEBUG   = __DEBUG__,
    RELEASE = __RELEASE__,
    COMMON  = __COMMON__,
}

------------------------------------------------------------

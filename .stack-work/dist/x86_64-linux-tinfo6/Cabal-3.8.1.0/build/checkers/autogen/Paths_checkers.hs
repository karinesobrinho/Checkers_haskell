{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_checkers (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/karine/Documentos/paradigmas/checkers/.stack-work/install/x86_64-linux-tinfo6/c3db4623b5d80a56bbf5f66f769263c9001d54db4e56ae72c4f67a77572fbd5c/9.4.6/bin"
libdir     = "/home/karine/Documentos/paradigmas/checkers/.stack-work/install/x86_64-linux-tinfo6/c3db4623b5d80a56bbf5f66f769263c9001d54db4e56ae72c4f67a77572fbd5c/9.4.6/lib/x86_64-linux-ghc-9.4.6/checkers-0.1.0.0-KgBBigSj2laHBHRTicgxrL-checkers"
dynlibdir  = "/home/karine/Documentos/paradigmas/checkers/.stack-work/install/x86_64-linux-tinfo6/c3db4623b5d80a56bbf5f66f769263c9001d54db4e56ae72c4f67a77572fbd5c/9.4.6/lib/x86_64-linux-ghc-9.4.6"
datadir    = "/home/karine/Documentos/paradigmas/checkers/.stack-work/install/x86_64-linux-tinfo6/c3db4623b5d80a56bbf5f66f769263c9001d54db4e56ae72c4f67a77572fbd5c/9.4.6/share/x86_64-linux-ghc-9.4.6/checkers-0.1.0.0"
libexecdir = "/home/karine/Documentos/paradigmas/checkers/.stack-work/install/x86_64-linux-tinfo6/c3db4623b5d80a56bbf5f66f769263c9001d54db4e56ae72c4f67a77572fbd5c/9.4.6/libexec/x86_64-linux-ghc-9.4.6/checkers-0.1.0.0"
sysconfdir = "/home/karine/Documentos/paradigmas/checkers/.stack-work/install/x86_64-linux-tinfo6/c3db4623b5d80a56bbf5f66f769263c9001d54db4e56ae72c4f67a77572fbd5c/9.4.6/etc"

getBinDir     = catchIO (getEnv "checkers_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "checkers_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "checkers_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "checkers_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "checkers_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "checkers_sysconfdir") (\_ -> return sysconfdir)




joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'

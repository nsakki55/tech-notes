fix_Mac <- function(sm) {
  stopifnot(is(sm, "stanmodel"))
  dso_last_path <- sm@dso@.CXXDSOMISC$dso_last_path
  CLANG_DIR <- tail(n = 1, grep("clang[456789]", 
                                x = list.dirs("/usr/local", recursive = FALSE), 
                                value = TRUE))
  if (length(CLANG_DIR) == 0L) stop("no clang from CRAN found")
  LIBCPP <- file.path(CLANG_DIR, "lib", "libc++.1.dylib")
  if (!file.exists(LIBCPP)) stop("no unique libc++.1?.dylib found")
  Rv <- R.version
  GOOD <- file.path("/Library", "Frameworks", "R.framework", "Versions", 
                    paste(Rv$major, substr(Rv$minor, 1, 1), sep = "."), 
                    "Resources", "lib", "libc++.1.dylib")
  if (!file.exists(GOOD)) stop(paste(GOOD, "not found"))
  cmd <- paste(
    "install_name_tool",
    "-change",
    LIBCPP,
    GOOD,
    dso_last_path
  )
  system(cmd)
  dyn.unload(dso_last_path)
  dyn.load(dso_last_path)
  return(invisible(NULL))
}
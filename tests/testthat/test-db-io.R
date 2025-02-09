test_that("db_copy_to() wraps DBI errors", {
  con <- local_sqlite_connection()
  local_db_table(con, data.frame(x = 1), "tmp")

  # error when writing
  expect_snapshot(
    (expect_error(
      db_copy_to(
        con = con,
        table = "tmp",
        values = data.frame(x = c(1, 1))
      )
    )),
    transform = snap_transform_dbi
  )

  # error when creating unique index
  expect_snapshot(
    (expect_error(
      db_copy_to(
        con = con,
        table = "tmp2",
        values = data.frame(x = c(1, 1)),
        unique_indexes = list("x")
      )
    )),
    transform = snap_transform_dbi
  )
})

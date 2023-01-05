sample_key <- "38a5603f-85b0-4d2e-ae43-3d0778272d60"
sample_key2 <- "4a0eafd5-bcfc-426b-a1fa-5193b161d7d3"

test_that("API checking fails with missing, inactive, or badly formatted key", {
  withr::local_options(apigpt.valid_api = FALSE)
  withr::local_envvar("OPENAI_API_KEY" = sample_key)
  expect_snapshot(check_api())
  withr::local_envvar("OPENAI_API_KEY" = "")
  expect_snapshot(check_api())
  withr::local_envvar("OPENAI_API_KEY" = "1234")
  expect_snapshot(check_api())
})

test_that("API checking works on CI", {
  mockr::local_mock(simple_api_check = function(api_check) 200)
  withr::local_options(apigpt.valid_api = FALSE)
  withr::local_envvar("OPENAI_API_KEY" = sample_key)
  expect_snapshot(check_api())
  expect_snapshot(check_api())
  withr::local_envvar("OPENAI_API_KEY" = sample_key2)
  expect_snapshot(check_api())
})

test_that("API checking works, assumes OPENAI_API_KEY is set", {
  skip_if_offline()
  skip_on_ci()
  withr::local_options(apigpt.valid_api = FALSE)
  expect_snapshot(check_api())
  # make sure skipping check works if first check works
  expect_snapshot(check_api())
  withr::local_envvar("OPENAI_API_KEY" = sample_key)
  expect_snapshot(check_api())
})

test_that("API key validation works", {
  expect_snapshot(check_api_key(sample_key))
  expect_snapshot(check_api_key("1234"))
  expect_snapshot(check_api_key(""))
})

test_that("API connection checking works", {
  expect_snapshot(check_api_connection(sample_key))
  expect_snapshot(check_api_connection(""))
})

test_that("API connection can return true", {
  skip_if_offline()
  skip_on_ci()
  withr::local_options(apigpt.valid_api = FALSE)
  expect_snapshot(check_api_connection(Sys.getenv("OPENAI_API_KEY")))
})

# ---------------------------------------------------------------

#mockr::local_mock(
#  get_selection = function() {
#    data.frame(value = "here is some selected text")
#  }
#)

#mockr::local_mock(insert_text <-  function(improved_text) improved_text)
sample_key <- uuid::UUIDgenerate()

test_that("gpt_edit can replace and append text", {
  mockr::local_mock(
    openai_create_edit =
      function(model, input, instruction, temperature, openai_api_key,
               openai_organization) {
        list(choices = data.frame(text = "here are edits openai returns"))
      }
  )
  mockr::local_mock(check_api = function() TRUE)
  replace_text <-
    gpt_edit(
      model = "code-davinci-edit-001",
      instruction = "instructions",
      temperature = 0.1,
      openai_api_key = sample_key,
      append_text = FALSE
    )
  expect_equal(replace_text, "here are edits openai returns")

  appended_text <-
    gpt_edit(
      model = "code-davinci-edit-001",
      instruction = "instructions",
      temperature = 0.1,
      openai_api_key = sample_key,
      append_text = TRUE
    )
  expect_equal(appended_text, c(
    "here is some selected text",
    "here are edits openai returns"
  ))
})


test_that("gpt_create can replace & append text", {
  mockr::local_mock(
    openai_create_completion =
      function(model, prompt, temperature, max_tokens,
               openai_api_key, openai_organization) {
        list(choices = data.frame(text = "here are completions openai returns"))
      }
  )
  mockr::local_mock(check_api = function() TRUE)
  replace_text <-
    gpt_create(
      model = "code-davinci-edit-001",
      temperature = 0.1,
      max_tokens = 500,
      openai_api_key = sample_key,
      append_text = FALSE
    )
  expect_equal(replace_text, "here are completions openai returns")

  appended_text <-
    gpt_create(
      model = "code-davinci-edit-001",
      temperature = 0.1,
      max_tokens = 500,
      openai_api_key = sample_key,
      append_text = TRUE
    )
  expect_equal(appended_text, c(
    "here is some selected text",
    "here are completions openai returns"
  ))
})

# ---------------------------------------------------------------

test_that("Spelling and grammer editing works", {
  mockr::local_mock(
    gpt_edit = function(model = "a-model",
                        instruction = "some instructions",
                        temperature = .05) {
      list("text" = "new text")
    }
  )
  expect_type(spesgAddin(), "list")
})
test_that("Translate spanish text to english", {
  mockr::local_mock(
    gpt_edit = function(model = "a-model",
                        instruction = "some instructions",
                        temperature = .05) {
      list("text" = "new text")
    }
  )
  expect_type(tspeAddin(), "list")
})


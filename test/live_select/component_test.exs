defmodule LiveSelect.ComponentTest do
  @moduledoc false

  use LiveSelectWeb.ConnCase, async: true
  alias LiveSelect.Component

  test "can be rendered" do
    component =
      render_component(Component, id: "live_select", form: :my_form, field: :live_select)
      |> Floki.parse_document!()

    assert component
           |> Floki.find("input#my_form_live_select[type=hidden]")
           |> Enum.any?()

    assert component
           |> Floki.find("input#my_form_live_select_text_input[type=text]")
           |> Enum.any?()
  end

  test "raises if invalid assign is passed" do
    assert_raise(RuntimeError, ~r(Invalid assign: "invalid_assign"), fn ->
      render_component(Component,
        id: "live_select",
        form: :my_form,
        field: :live_select,
        invalid_assign: "foo"
      )
    end)
  end

  test "raises if _extra_class option is used with styles == :none" do
    assert_raise(
      RuntimeError,
      ~r/when using `style: :none`, please use only `container_class`/i,
      fn ->
        render_component(Component,
          id: "live_select",
          form: :my_form,
          field: :live_select,
          style: :none,
          container_extra_class: "foo"
        )
      end
    )
  end
end

class SandboxTag < Liquid::Tag
  def initialize(tag_name, sandbox_name, tokens)
     super
     @sandbox_name = sandbox_name
  end

  def render(context)
    page = context.environments[0]["page"].instance_eval { @page }
    sandbox = page.sandboxes.find_by_name(@sandbox_name) || page.sandboxes.create
    sandbox.render
  end
end

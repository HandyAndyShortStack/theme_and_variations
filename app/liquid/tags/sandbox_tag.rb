class SandboxTag < Liquid::Tag
  def initialize(tag_name, sandbox_name, tokens)
     super
     @sandbox_name = sandbox_name.strip
  end

  def render(context)
    page = context.environments[0]["page"].instance_eval { @page }
    sandbox = page.sandboxes.find_or_create_by_name(@sandbox_name)
    sandbox.render
  end
end

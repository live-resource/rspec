module LiveResource
  module RSpec
    def dependencies_on(resource, target)
      resource.dependencies.select { |dependency| dependency.target == target }
    end

    def dependency_on(resource, target)
      dependencies_on(resource, target).first
    end
  end
end
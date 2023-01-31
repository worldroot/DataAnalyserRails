class HomeController < ApplicationController
  def index
  end

  def index_trace_forum
    @forums = Forum.all.group(:kpi_d, :id_reference_tf).sum(:kpi_d)
    @top_users = UserForum.group(:name, :id).order("kpi_a DESC")
    @top_forums = Forum.group(:kpi_d, :id).order("kpi_d DESC")
  end

  def terms
  end

  def privacy
  end
end

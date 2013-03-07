class ContextsDatatable
  delegate :params, :h, :link_to, :number_to_currency, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Context.count,
      iTotalDisplayRecords: contexts.total_entries,
      aaData: data
    }
  end

private

  def data
    contexts.map do |context|
      {
        "0" => h(context.name),
        "1" => h(context.description),
        "DT_RowId" => context.id,
        "DT_RowClass" => "gradeA"
      }
    end
  end

  def contexts
    @contexts ||= fetch_contexts
  end

  def fetch_contexts
    contexts = Context.order("#{sort_column} #{sort_direction}")
    contexts = contexts.page(page).per_page(per_page)
    if params[:sSearch].present?
      contexts = contexts.where("name like :search", search: "%#{params[:sSearch]}%")
    end
    contexts
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[name description]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end

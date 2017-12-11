module JobsHelper
  def display_company_banner company
    image_tag(company.banner.url) if company.banner.url.present?
  end

  def information_job job, commany
    [t("recruit", company: commany.name), "\n"+ job.name, "\n"+
      t("jobs.show.salary") + job.max_salary.round.to_s + Settings.currency.dollar]
  end
end

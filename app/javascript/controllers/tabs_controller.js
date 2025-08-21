import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tab", "content"]

  connect() {
    // Set default active tab (first one)
    if (this.hasTabTarget && this.hasContentTarget) {
      this.showTab(this.tabTargets[0].dataset.tabsName)
    }
  }

  show(event) {
    const name = event.currentTarget.dataset.tabsName
    this.showTab(name)
  }

  showTab(name) {
    // Hide all content
    this.contentTargets.forEach(el => {
      el.classList.add("hidden")
      el.classList.remove("block")
    })

    // Deactivate all tabs
    this.tabTargets.forEach(el => {
      el.classList.remove("border-indigo-500", "text-indigo-600")
      el.classList.add("border-transparent", "text-gray-500")
    })

    // Show active content
    const activeContent = this.contentTargets.find(el => el.dataset.tabsName === name)
    if (activeContent) {
      activeContent.classList.remove("hidden")
      activeContent.classList.add("block")
    }

    // Highlight active tab
    const activeTab = this.tabTargets.find(el => el.dataset.tabsName === name)
    if (activeTab) {
      activeTab.classList.remove("border-transparent", "text-gray-500")
      activeTab.classList.add("border-indigo-500", "text-indigo-600")
    }
  }
}

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    mapboxgl.accessToken = 'YOUR_MAPBOX_ACCESS_TOKEN' // Replace with your token
    this.map = new mapboxgl.Map({
      container: 'map',
      style: 'mapbox://styles/mapbox/streets-v12',
      center: [-98, 39],
      zoom: 4
    })

    fetch('/ads.json')
      .then(resp => resp.json())
      .then(ads => {
        ads.forEach(ad => this.addMarker(ad))
      })
  }

  addMarker(ad) {
    const el = document.createElement('div')
    el.className = 'marker-blip'
    el.style.width = '18px'
    el.style.height = '18px'
    el.style.borderRadius = '50%'
    el.style.background = '#007cbf'
    el.style.boxShadow = '0 0 8px #007cbf88'

    const marker = new mapboxgl.Marker(el)
      .setLngLat([ad.longitude, ad.latitude])
      .setPopup(
        new mapboxgl.Popup({ offset: 25 })
          .setHTML(this.popupHtml(ad))
      )
      .addTo(this.map)
  }

  popupHtml(ad) {
    let images = ad.images ? ad.images.split(',').map(url =>
      `<img src="${url.trim()}" style="width:100px;border-radius:8px;margin:4px 0;">`
    ).join('') : ''
    return `
      <div style="font-family:sans-serif;min-width:220px;">
        <h3 style="margin:0 0 4px 0;">${ad.title}</h3>
        <div>${images}</div>
        <p style="margin:4px 0;">${ad.description}</p>
        <button data-action="click->ads-map#showReviewForm" data-ad-id="${ad.id}" style="background:#007cbf;color:white;border:none;padding:6px 12px;border-radius:4px;cursor:pointer;">Leave Review</button>
        <button data-action="click->ads-map#plusService" data-ad-id="${ad.id}" style="margin-left:8px;background:#38c172;color:white;border:none;padding:6px 12px;border-radius:4px;cursor:pointer;">+ Service</button>
        <button data-action="click->ads-map#minusService" data-ad-id="${ad.id}" style="margin-left:4px;background:#e3342f;color:white;border:none;padding:6px 12px;border-radius:4px;cursor:pointer;">- Service</button>
      </div>
    `
  }

  showReviewForm(event) {
    const adId = event.target.dataset.adId
    const popup = document.querySelector('#ad-popup')
    popup.innerHTML = `
      <form data-action="submit->ads-map#submitReview" data-ad-id="${adId}" style="background:white;padding:16px;border-radius:8px;box-shadow:0 2px 8px #0002;">
        <label>Rating:
          <select name="rating">
            <option>5</option><option>4</option><option>3</option><option>2</option><option>1</option>
          </select>
        </label>
        <br>
        <label>Comment:<br>
          <textarea name="comment" style="width:100%;"></textarea>
        </label>
        <br>
        <button type="submit" style="background:#007cbf;color:white;padding:6px 12px;border:none;border-radius:4px;margin-top:8px;">Submit</button>
      </form>
    `
    popup.style.display = 'block'
  }

  submitReview(event) {
    event.preventDefault()
    const adId = event.target.dataset.adId
    const formData = new FormData(event.target)
    fetch(`/ads/${adId}/reviews`, {
      method: 'POST',
      headers: { 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content },
      body: formData
    }).then(() => {
      document.querySelector('#ad-popup').style.display = 'none'
      alert('Review submitted!')
    })
  }

  plusService(event) {
    const adId = event.target.dataset.adId
    this.recordImpression(adId, 'plus')
  }

  minusService(event) {
    const adId = event.target.dataset.adId
    this.recordImpression(adId, 'minus')
  }

  recordImpression(adId, type) {
    fetch(`/ads/${adId}/impressions`, {
      method: 'POST',
      headers: { 'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content, 'Content-Type': 'application/json' },
      body: JSON.stringify({ impression_type: type })
    }).then(() => {
      alert(`${type === 'plus' ? '+' : '-'} Service recorded!`)
    })
  }
}

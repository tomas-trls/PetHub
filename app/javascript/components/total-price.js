

const calculatePrice = () => {
  let startDateInput = document.querySelector('#booking_start_date');
  let endDateInput = document.querySelector('#booking_end_date');
  let totalPriceHTML = document.querySelector('#total-price').innerText
  let totalPrice = parseFloat(totalPriceHTML);

  let startSeconds = 0;
  let endSeconds = 0;
  let days = 0;
  let originalPrice = totalPrice;


  let endDate = endDateInput.addEventListener('change', event => {
    endSeconds = 0;

    endSeconds = Date.parse(event.currentTarget.value);
    days = (endSeconds - startSeconds) / 60 / 60 / 24 / 1000;
    let price = originalPrice * days;
    if (price > 0 ){
      document.querySelector('#total-price').innerText = (Math.round(price * 100) / 100).toString();
      document.getElementById("booking_price").value = (Math.round(price * 100) / 100).toString()
    } else {
      alert("Your end date cannot be prior to your start date ");
    }
  });

  let starDate = startDateInput.addEventListener('change', event => {
  startSeconds = Date.parse(event.currentTarget.value)
  endSeconds = Date.parse(event.currentTarget.value);
  days = (endSeconds - startSeconds) / 60 / 60 / 24 / 1000;
  let price = originalPrice * days;
  document.querySelector('#total-price').innerText = (Math.round(price * 100) / 100).toString();
  document.getElementById("booking_price").value = (Math.round(price * 100) / 100).toString()
  });
};

export { calculatePrice }

























// const toggleDateInputs = function () {
//   const pricePerDay = parseFloat(document.querySelector(".price").dataset.price);
// //   const totalPrice = document.getElementById("price");


//   const startDateInput = document.getElementById('booking_start_date');
//   const endDateInput = document.getElementById('booking_end_date');


// //   if (startDateInput && endDateInput) {
// //     const unavailableDates = JSON.parse(document.querySelector('.widget-content').dataset.unavailable)

// //     flatpickr(startDateInput, {
// //       minDate: 'today',
// //       dateFormat: 'Y-m-d',
// //       disable: unavailableDates,
// //       onChange: function (selectedDates, selectedDate) {
// //         if (selectedDate === '') {
// //           endDateInput.disabled = true;
// //         }
// //         let minDate = selectedDates[0];
// //         minDate.setDate(minDate.getDate());
// //         endDateCalendar.set('minDate', minDate);
// //         endDateInput.disabled = false;
// //       }
// //     });
// //     const endDateCalendar =
// //       flatpickr(endDateInput, {
// //         dateFormat: 'Y-m-d',
// //         disable: unavailableDates,
// //         onChange: function (_, selectedDate) {
// //           if (selectedDate === '') {
// //           } else {
// //             const diff = Date.parse(endDateInput.value) - Date.parse(startDateInput.value)
// //             const numOfDays = diff / 1000 / 60 / 60 / 24 + 1

// //             const newPrice = pricePerDay * numOfDays;
// //             totalPrice.innerHTML = `£ ${newPrice}`;
// //             // Update the value of the read - only input
// //             priceInput.value = newPrice;
// //           }
// //         },
// //       });
// //   }
// };

// export { toggleDateInputs }

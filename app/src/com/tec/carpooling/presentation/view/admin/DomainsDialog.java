package com.tec.carpooling.presentation.view.admin;

import com.tec.carpooling.business.service.DomainService;
import com.tec.carpooling.business.service.InstitutionService;
import com.tec.carpooling.business.service.impl.DomainServiceImpl; // DI!
import com.tec.carpooling.business.service.impl.InstitutionServiceImpl; // DI!
import com.tec.carpooling.dto.DomainDTO;
import com.tec.carpooling.exception.InstitutionManagementException;

import javax.swing.*;
import java.awt.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.Vector;

public class DomainsDialog extends JDialog {

    private final long institutionId;
    private final InstitutionService institutionService; // Inyectar!
    private final DomainService domainService;          // Inyectar!

    private JList<DomainCheckboxListItem> domainList;
    private DefaultListModel<DomainCheckboxListItem> listModel;
    private JButton btnSave;
    private JButton btnCancel;

    // Constructor que recibe el ID de la institución y los servicios
    public DomainsDialog(Frame owner, boolean modal, long institutionId) {
        super(owner, modal);
        this.institutionId = institutionId;

        // --- ¡¡MEJORAR ESTO CON INYECCIÓN DE DEPENDENCIAS!! ---
        this.institutionService = new InstitutionServiceImpl();
        this.domainService = new DomainServiceImpl();
        // ---

        initComponents();
        loadDomains();
        setTitle("Gestionar Dominios para Institución ID: " + institutionId);
        pack(); // Ajusta el tamaño
        setLocationRelativeTo(owner); // Centra relativo al padre
    }

    private void initComponents() {
        listModel = new DefaultListModel<>();
        domainList = new JList<>(listModel);
        domainList.setCellRenderer(new DomainCheckboxListRenderer()); // Renderer personalizado
        domainList.setSelectionMode(ListSelectionModel.SINGLE_SELECTION);
        // Añadir MouseListener para cambiar el estado del checkbox al hacer clic
        domainList.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                int index = domainList.locationToIndex(evt.getPoint());
                if (index >= 0) {
                    DomainCheckboxListItem item = listModel.getElementAt(index);
                    item.setSelected(!item.isSelected());
                    // Redibujar el item específico
                    listModel.setElementAt(item, index); // Fuerza la actualización visual
                }
            }
        });

        JScrollPane scrollPane = new JScrollPane(domainList);
        scrollPane.setPreferredSize(new Dimension(350, 250)); // Tamaño preferido

        btnSave = new JButton("Guardar Cambios");
        btnCancel = new JButton("Cancelar");

        btnSave.addActionListener(e -> saveAssociations());
        btnCancel.addActionListener(e -> dispose()); // Cierra el diálogo

        // Layout (ejemplo simple con BorderLayout y un panel para botones)
        JPanel buttonPanel = new JPanel(new FlowLayout(FlowLayout.RIGHT));
        buttonPanel.add(btnCancel);
        buttonPanel.add(btnSave);

        setLayout(new BorderLayout(5, 5));
        add(new JLabel("Seleccione los dominios asociados:"), BorderLayout.NORTH);
        add(scrollPane, BorderLayout.CENTER);
        add(buttonPanel, BorderLayout.SOUTH);
    }

    private void loadDomains() {
        try {
            // 1. Obtener todos los dominios globales
            List<DomainDTO> allDomains = domainService.getAllDomains();

            // 2. Obtener los IDs de dominio actualmente asociados a ESTA institución
            List<Long> associatedDomainIdsList = institutionService.getDomainIdsForInstitution(institutionId);
            Set<Long> associatedDomainIds = new HashSet<>(associatedDomainIdsList); // Más eficiente para buscar

            // 3. Poblar el ListModel
            listModel.clear();
            for (DomainDTO domain : allDomains) {
                DomainCheckboxListItem item = new DomainCheckboxListItem(domain);
                // Marcar como seleccionado si está en el set de asociados
                if (associatedDomainIds.contains(domain.getId())) {
                    item.setSelected(true);
                }
                listModel.addElement(item);
            }

        } catch (Exception e) {
            // Loggear error
            JOptionPane.showMessageDialog(this,
                    "Error al cargar los dominios: " + e.getMessage(),
                    "Error de Carga", JOptionPane.ERROR_MESSAGE);
            // Podrías deshabilitar el diálogo o cerrarlo si la carga falla
        }
    }

    private void saveAssociations() {
        // 1. Recolectar los IDs de los dominios SELECCIONADOS en la lista
        List<Long> selectedDomainIds = new ArrayList<>();
        for (int i = 0; i < listModel.getSize(); i++) {
            DomainCheckboxListItem item = listModel.getElementAt(i);
            if (item.isSelected()) {
                selectedDomainIds.add(item.getDomain().getId());
            }
        }

        // 2. Llamar al servicio para actualizar las asociaciones
        try {
            boolean success = institutionService.updateDomainAssociationsForInstitution(institutionId, selectedDomainIds);
            if (success) {
                JOptionPane.showMessageDialog(this, "Asociaciones de dominio actualizadas correctamente.");
                dispose(); // Cerrar el diálogo si fue exitoso
            } else {
                // Esto no debería pasar si el servicio lanza excepciones en caso de error
                JOptionPane.showMessageDialog(this, "La actualización de dominios falló.", "Error", JOptionPane.ERROR_MESSAGE);
            }
        } catch (InstitutionManagementException e) {
             JOptionPane.showMessageDialog(this, "Error al guardar: " + e.getMessage(), "Error de Guardado", JOptionPane.WARNING_MESSAGE);
        }
        catch (Exception e) {
            // Loggear error
            JOptionPane.showMessageDialog(this, "Error inesperado al guardar: " + e.getMessage(), "Error", JOptionPane.ERROR_MESSAGE);
        }
    }

    // --- Clases Internas para el JList con Checkboxes ---

    // Item que contiene el Dominio y su estado de selección
    private static class DomainCheckboxListItem {
        private final DomainDTO domain;
        private boolean isSelected = false;

        public DomainCheckboxListItem(DomainDTO domain) {
            this.domain = domain;
        }

        public boolean isSelected() {
            return isSelected;
        }

        public void setSelected(boolean selected) {
            isSelected = selected;
        }

        public DomainDTO getDomain() {
            return domain;
        }

        @Override
        public String toString() {
            return domain.getName(); // Texto que se muestra en la lista
        }
    }

    // Renderer que dibuja el checkbox y el texto
    private static class DomainCheckboxListRenderer extends JCheckBox implements ListCellRenderer<DomainCheckboxListItem> {
        @Override
        public Component getListCellRendererComponent(JList<? extends DomainCheckboxListItem> list,
                                                      DomainCheckboxListItem value,
                                                      int index,
                                                      boolean isSelected, // Selección de la fila (no del checkbox)
                                                      boolean cellHasFocus) {
            setEnabled(list.isEnabled());
            setSelected(value.isSelected()); // Estado del checkbox interno
            setFont(list.getFont());
            setBackground(isSelected ? list.getSelectionBackground() : list.getBackground());
            setForeground(isSelected ? list.getSelectionForeground() : list.getForeground());
            setText(value.toString());
            return this;
        }
    }
}